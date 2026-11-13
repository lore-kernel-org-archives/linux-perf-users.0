Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582953;
	b=lf05O3XXn3K9iF5wnq6/i89PFQoIMu4TEiVuIgv7rx+C2N+2KDYHwUetn3wjs9JGnU/C
	 3dG/SKCYVEWJGMhfnl/HnvsIu+xY7i9y+HpY+SufeZWVuaoL6ZnCNffrhwoS7WI551keB
	 e+pdGIyIvRs0kQAqg4l3D6YH4fmPhz1mKd6PkqH7wa3iEEOJyq9Nw4Zzbp2dBsoSxIJzD
	 WwabfgTSWb+ddoyqpB7RFHux4Akb2mhcRIibrJE1FpNiIGkn65QM+GjoQo+DRGOoHH2/8
	 FuB/+04P/hvAoC7Q7mg/nHh8g0V04EGcuKRpY41JZ4w6hxucJOeT/ERmgmhJ+FIJNfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582953;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=V1YWPttXEi6HW26RX2hE76PCKuzOoDlXU7K4UAZ3+NM=;
	b=Qc5zfa6Zx7sMOodbZh9vabwQiljTnKXe0N61xazvUaH8jGpxQzvcFpSyB5mpMnQxxMkO
	 IzukYgJ6SODaRTRdBnH8OdOxqqR42kmAJsexuRf1icJrHwwA+FkMnKqHWgducSx7Krkmb
	 6QmQEEjrJ1Q9H7n/glIom9UHNmlfV9Yyik1/AF/Lgx+DpX5La/TXa+IhyHN53mpirRCmh
	 ev5Pj/QZhRdhtHvv/nBBSAN621o6um93WC6nLBoJ5HsbFpm6LK8SYpsKFyUZAFriKyFjV
	 QIPDIGX6v/3TJkMD1d762zWSmAGvwVnUdVInX4tGHaTTjTELWbsygGCICo6j6f+BMgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=qXQmrCKd;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63F1606A339;
	Fri, 13 Nov 2026 15:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E63F1606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=qXQmrCKd
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EF42339;
	Fri, 13 Nov 2026 07:15:49 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFC833F85F;
	Fri, 13 Nov 2026 07:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794582952; bh=8/RunaI4RGgcBAEHTWjUlS5O+ROOwppaIYc4rMMVIgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qXQmrCKdi1XXeajyZbt39aciqGvxmgxylKAOnZn9jFgyQyQT0v3dVwUbv043MzOew
	 ZkQ3ZE4Lyo37EbONSQS25IILhW1hwvz2fcMG4WRg4ebIDlK7rDaERQ++wlT1sdV/R3
	 XHgX7CusAxNk7G8oJIaQ+uGx9pbcs0ualP1x0W3U=
Date: Fri, 13 Nov 2026 15:15:49 +0000
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Mike Leach <mike.leach@arm.com>,
	Robert Walker <robert.walker@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 09/12] perf cs-etm: Fall back to the recorded
 instruction size on a failed read
Message-ID: <20261113151549.GR9176@e132581.arm.com>
References: <20261113150555.1163049-1-acme@kernel.org>
 <20261113150555.1163049-10-acme@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113150555.1163049-10-acme@kernel.org>

Hi Arnaldo,

On Fri, Nov 13, 2026 at 12:05:50PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> cs_etm__t32_instr_size() reads the instruction bytes from the traced
> program's memory to tell a 16-bit from a 32-bit T32 instruction, but it
> ignores cs_etm__frontend_mem_access() failing, which happens when the
> DSO or its debug data is missing, and then reads the uninitialized
> buffer.  GCC 16 warns about it and build-test fails with -Werror.
> 
> Use the instruction size recorded by the decoder, as the A32/A64 path
> already does, when the read doesn't return the full two bytes.

This patch is duplicate with:

https://lore.kernel.org/linux-perf-users/20261113-perf_fix_gcc15_failure-v1-0-eae592c5ff64@arm.com/T/#m5f610e381705bc587a9ce3d31be4e1e0ed595506

I prefer that one, it handle cs_etm__frontend_mem_access() failure
throughly.
