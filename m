Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003E935B653;
	Tue, 22 Sep 2026 01:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039037; cv=none; b=Z0eyHceAC19rwrAjB0PQVVgZlvgMJl9E4wqogA9GO/hBAi9JHyOpvgZD0bPll6jLjnb5/uQzWaafb/qmjkzSJW9NgNAjENZIIvMSPlBlPhdEhOJIV5g+CSscKI6z1iFtosul3mIgajLrSFSZUYhka9zfxC4+oNSyErMhfmg9HSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039037; c=relaxed/simple;
	bh=pusGeEZqiSSnffuAl1XGeav1ixUkBW26DyhkHYQ/WxM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aNyGATI3cS//7rqr6CKXbiGaIck9dk5q9KRC7OkzPEAWhCrnJXfeVkJBQMDIsqJUCmKJnKlvwHIbibNxPTUXEUrt416PyBpTI8Cq9yzxB1N/qN8BYd5WHrnpEPNN8h2h06tGIdfvdQ4+PgKNbiI2j6tGVzkvdCyG8VjVX2vTJfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIOZXsf6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIOZXsf6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F121F00893;
	Tue, 22 Sep 2026 01:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790039035;
	bh=i5aAvN5nmxe/JfVR/rduOFntvNije13li6N+Ykm0QIk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EIOZXsf6233lmdx+SpxplHD6yl9Pqw+rMa69uIDm7ujuu2iTDzGnYtuhJZffLe4KN
	 sBjkL1+WY1DWapufJ1W8/VmnUv4mEic3XOcQpBhi0zG+NxZTOhtVLE2rk7o6Nlp4Ao
	 KlE3sZ9lvMdVEqoJzx00ej2tiHyEw+q0+6+Wiv2L0BPNyQZrquY+ugbXuOxXa1UoEI
	 GzTyfMvktuL/xQvn27hudE+xeOSeuNTsgQXkipbasb42YyMG4rhr6M8ljNOd2msekk
	 qiEySfRlKIS9+GQ2N4jJN1uO3etPY+TQEi75elQtoIzQxwCX5eSmguPV8F4ppnnTHm
	 yTV+Ku5yds9hg==
Date: Tue, 22 Sep 2026 02:03:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org,
 will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net,
 robin.murphy@arm.com, icheng@nvidia.com
Subject: Re: [RESEND PATCH v4 05/11] perf/cxl: Split the MSI vector out of
 info->irq
Message-ID: <20260922020349.213d390c@jic23-hlaptop>
In-Reply-To: <20260805155911.1304807-6-dave.jiang@intel.com>
References: <20260805155911.1304807-1-dave.jiang@intel.com>
	<20260805155911.1304807-6-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Aug 2026 08:59:05 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> info->irq means two different things depending on how far probe has got.
> cxl_pmu_parse_caps() sets it to the MSI/MSI-X message number from the CPMU
> Capability register. cxl_pmu_probe() passes that to pci_irq_vector() and
> then overwrites it with the Linux virq, which is what the hotplug callbacks
> hand to irq_set_affinity().
> 
> Both are ints called irq, so nothing catches a mix-up, and the valid ranges
> differ. 0 is a fine message number but never a valid virq.
> 
> Give the message number its own field. No functional change.
> 
> Assisted-by: Claude:claude-opus-4-8
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
