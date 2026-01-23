Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D2630F93C
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 14:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769178431; cv=none; b=Jvo2FNSGeX8aAa0MLPl+cagbB/YR4gWReswMnY6ltdmmjqA3FMFdERBXK0tqqpjjahhB9D79xRATPmhKP5Pl8Tam7aw8x5GYttTo+tIHD9rWradQ3DSV6EY1Df3EwKzTP6u2xw0kSgbLDRf6/bQM6UyteXWPMWCb/2BZ2oZutvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769178431; c=relaxed/simple;
	bh=Eb77ID3UnO3ePz3cljWhsayZrA0trFF+xq3jcmAhpvc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=k337AmF/NPn4GUEV+9Io5UcfLWcvgrH8PcJb+qbRyHOv7e+zwGBWvNrgs5N4/DmZDB3gTV/jAJlnZ8jFAWeIH/REaiCiTb2giy7bHt6w7FhnlvAJ1u81c6Jz48ll7zqQvk6t6SbX0FGCOPHwhyNMN1CperN4HC2lVBo2sQyG/i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U8HnDGga; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8HnDGga"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769178426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Oj3kc35jazdHGK3EMpfjOpIQ4hKn3RMT1LLNy1PFV4=;
	b=U8HnDGgai9KUOqNP3wiBalApFnFfn7vkjhUJY7/e5ioNVEzoVoaEo5qQL6ETPH0hJNYJ0W
	UrzvyZWn/4s25uZkJp+JUnJqu6jwGgpW0gXzeipKnyMovrVcSX/LjFloPYPFJmb4SKYeQC
	NzwC1PNUBXcg9ce+tbMwbKuEhKW4S1o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-uPpw8eybM-qA0_yLrVbmjw-1; Fri,
 23 Jan 2026 09:27:02 -0500
X-MC-Unique: uPpw8eybM-qA0_yLrVbmjw-1
X-Mimecast-MFC-AGG-ID: uPpw8eybM-qA0_yLrVbmjw_1769178421
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5293F19775A5;
	Fri, 23 Jan 2026 14:27:01 +0000 (UTC)
Received: from Carbon (unknown [10.45.242.13])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6F0618004D8;
	Fri, 23 Jan 2026 14:26:58 +0000 (UTC)
Date: Fri, 23 Jan 2026 15:26:54 +0100 (CET)
From: Michael Petlan <mpetlan@redhat.com>
To: Jakub Brnak <jbrnak@redhat.com>
cc: acme@kernel.org, acme@redhat.com, linux-perf-users@vger.kernel.org, 
    namhyung@kernel.org, irogers@google.com
Subject: Re: [PATCH v5 0/7] Introduce structure for shell tests
In-Reply-To: <20251125155648.197527-1-jbrnak@redhat.com>
Message-ID: <a5f59c64-0da-6928-7a9-c5b6c2be8ef8@redhat.com>
References: <20251125155648.197527-1-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hello Ian and Namhyung,

kindly reminding this patchset. Could we get it merged soon please?
Or is there still anything to address?

Thanks in advance!

Regards,
Michael

On Tue, 25 Nov 2025, Jakub Brnak wrote:
> Hi maintainers,
> 
> This revision of series of patches continues the effort of upstreaming a perftool-testsuite and 
> incorporates the review feedback that was previously discussed.
> A new patch (7/7) was added to fix the incorrect relative path for locating stderr-whitelist.txt 
> in report tests.
> 
> Thanks,
> Jakub
> 
> Link to v4: https://lore.kernel.org/linux-perf-users/20250930160923.13728-1-jbrnak@redhat.com/#t
> 
> Changes since v4:
> Patch 1: applied review feedback, renamed shell_info -> shell_test_info, minor cleanups
> Patch 2: renamed shell_info -> shell_test_info
> Patch 4: renamed shell_info -> shell_test_info
> Patch 7: added in v5, fix for relative path to 
> stderr-whitelist.txt in report tests
> 
> Jakub Brnak (7):
>   perf tests: Create a structure for shell tests
>   perf test: Provide setup for the shell test suite
>   perftool-testsuite: Add empty setup for base_probe
>   perf test: Introduce storing logs for shell tests
>   perf test: Format log directories for shell tests
>   perf test: Remove perftool drivers
>   perf test: Fix relative path for 'stderr-whitelist.txt'
> 
>  tools/perf/tests/builtin-test.c               | 129 +++++++-
>  tools/perf/tests/shell/base_probe/setup.sh    |  13 +
>  .../tests/shell/base_report/test_basic.sh     |   6 +-
>  .../tests/shell/perftool-testsuite_probe.sh   |  24 --
>  .../tests/shell/perftool-testsuite_report.sh  |  23 --
>  tools/perf/tests/tests-scripts.c              | 288 +++++++++++++++---
>  tools/perf/tests/tests-scripts.h              |  15 +
>  tools/perf/tests/tests.h                      |   8 +-
>  8 files changed, 398 insertions(+), 108 deletions(-)
>  create mode 100755 tools/perf/tests/shell/base_probe/setup.sh
>  delete mode 100755 tools/perf/tests/shell/perftool-testsuite_probe.sh
>  delete mode 100755 tools/perf/tests/shell/perftool-testsuite_report.sh
> 
> -- 
> 2.51.1
> 
> 

