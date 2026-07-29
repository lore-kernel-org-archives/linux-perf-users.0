Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447EF3B14C7;
	Wed, 29 Jul 2026 19:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352662; cv=none; b=oNWSDyQA71K4fnKkz3eZmW7OTNBoME4BqnXogRWXK8tU8lO61pychm13KIvaOolwLo028m1gXdmJRRcc7ldh0ZJ2ZMPmdbiNDnxgHZGI0swXUcXaj2vyLw4z5xaIb1Go0qP3iLEG0CW/labEW/YzdceDWiSZybot2MWnqd2FbVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352662; c=relaxed/simple;
	bh=/UllsaKlsEzKYGf056WkduNV4t0d+ZhSF6qLs8cLd6k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HXU1blHaGq5zTdiIXN5CO8edIMO72qLFlUpOxnV06GHn5iaeuFt/BcBtjZlD15Gm3xumTns8du5cCCNNNau205v3AVRVHInSekGuwS3J+BXdQ49mSg832YfwMpzKyAtuCV5r0FUvzacbBdsrzqTiCGW4ZI6sOT38jRft5aukUzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxrRQPfj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxrRQPfj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66B81F000E9;
	Wed, 29 Jul 2026 19:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352658;
	bh=JmA2roCmdeGl87un3KTslDkWWTt07wNFmSTeZnHp5p0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NxrRQPfj5qBTNdeM+ejsC0AC9oTwvLDI1W1stB38vd1mW/gpY4O4aeQjOddweqbjr
	 wpaDw448B6QH3+nANNRWx7pgqdhqfoZFDb3OueMearKK9GIhi0cGGJZ6pU+8vKOOH6
	 bDuUUxaF64kkVOaWQ7r3R68dprtAkDDWZlqIEgvA69HEAx2g5pnwa58+aoDLbzRvya
	 a6Nvy0wRYf2IQrQP3ccBr1qKy7R8VeWxLqtFDtxxVXt3iBdg0sY2elLXaIgYPGVgwY
	 +xkaqtuSiGvJqoQ0fLlYAF9BGsHq3Yf0o8YpV7RKqQEiVfkf+NN6CG5bRYujWQs0+m
	 ACX++o2POwsjA==
Date: Wed, 29 Jul 2026 20:17:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org,
 will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net,
 sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/9] perf/cxl: Don't use pmu.dev in IRQ and hotplug
 callbacks after unregister
Message-ID: <20260729201732.493818b4@jic23-huawei>
In-Reply-To: <20260729145555.3919550-9-dave.jiang@intel.com>
References: <20260729145555.3919550-1-dave.jiang@intel.com>
	<20260729145555.3919550-9-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jul 2026 07:55:54 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On device removal the devm actions unwind LIFO, so cxl_pmu_perf_unregister()
> runs first and perf_pmu_unregister() frees info->pmu.dev (device_del() +
> put_device() -> kfree()). The overflow IRQ (freed last) and the CPU-hotplug
> instance (removed next) are still live at that point, and both
> cxl_pmu_irq() and cxl_pmu_offline_cpu() log via dev_dbg()/dev_err() on
> info->pmu.dev, dereferencing freed memory. The shared IRQ can be entered
> for a co-function on the same MSI vector, and a CPU can go offline in the
> window before the hotplug instance is removed.
> 
> Log through info->pmu.parent instead, the cxl_pmu device passed to probe,
> which is devm-managed and outlives every teardown action.
> 
> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

In general logging on subsystem devices is flakey so

Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  drivers/perf/cxl_pmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 2e817a52ff1e..f42238b2b6b0 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -803,7 +803,7 @@ static irqreturn_t cxl_pmu_irq(int irq, void *data)
>  		struct perf_event *event = info->hw_events[i];
>  
>  		if (!event) {
> -			dev_dbg(info->pmu.dev,
> +			dev_dbg(info->pmu.parent,
>  				"overflow but on non enabled counter %d\n", i);
>  			continue;
>  		}
> @@ -966,7 +966,7 @@ static int cxl_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
>  	info->on_cpu = -1;
>  	target = cpumask_any_but(cpu_online_mask, cpu);
>  	if (target >= nr_cpu_ids) {
> -		dev_err(info->pmu.dev, "Unable to find a suitable CPU\n");
> +		dev_err(info->pmu.parent, "Unable to find a suitable CPU\n");
>  		return 0;
>  	}
>  

