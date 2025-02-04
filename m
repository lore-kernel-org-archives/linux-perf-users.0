Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFA6204C3C;
	Tue,  4 Feb 2025 07:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738654871; cv=none; b=LD+s9LXpVTykRm9t1HLclGTsww9t4VPwtXeD5vAN1AG1N9gLfE4Jhqi9kAtYc6+LOzqJL8ayHTjJ7oh0zsARDzsDjloeoUkFMuZgbvT0KJdNmX+giX5gkJIuB1kv6Qox4lyKm/Q/xyu8NkWPoBrIu10VYACWahzZAQg3+YB98Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738654871; c=relaxed/simple;
	bh=YBwjpDG79eWe7a7LMa4APeW8l9hXzSu8b4Zd2OK0P5Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b+O0eN64xF9uuBUD1l1kWT+aMXHG5m/3LHadBLtWIT3v9CqGaW2C7p/8T7VHsxRaFBWZcgpRcSpAYrzP7WT8DVf19AY6G2M605uKWrp9eqvO9MjTZOCbIQCpDqp3xomSHH8bIIoltC5qVSDC5pbhT9TiImFwhd0CZie+ZlVoZtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gKZhJoS9; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gKZhJoS9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738654869; x=1770190869;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=YBwjpDG79eWe7a7LMa4APeW8l9hXzSu8b4Zd2OK0P5Y=;
  b=gKZhJoS9qWLf7Rli8rUjHTifFHyRLr8jehLBC+cAfAR0LcWeuMr+wUFM
   ucXkSi/lP0GCDlGIy9q69FTZqKfTguQcrQh7WMyO5BSvtf74i1XajNkS+
   d5PUBN1ullo/0getkDpktgj2XuHqtbRCKgdvkuXnk04ktgmAY9s01ht6g
   Cyv9wEgoeYaO9rzIxAV7fpYaHvc1U5LhG2ext+evirPCJ7M4ZansjB62L
   gxVmbwwF4e8G1nsD6A66AvriiCKaMgj2jzc98ulRaLIVJsFaxwuQ9bIVu
   iJo1L1+2NgTEiTjHuXHTmBff10/82IBxElVAaOrmsBU8XmABA5b4jqLIf
   A==;
X-CSE-ConnectionGUID: V4nSkuiFTIGzzEVYvhKe4A==
X-CSE-MsgGUID: c718eJ3oQSW2SZAGxhjLnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="49426102"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="49426102"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 23:41:09 -0800
X-CSE-ConnectionGUID: 9dr/5ulYSwSgoYtxy/Z9JQ==
X-CSE-MsgGUID: 7jnhrtbRQFef0sB/MuOhgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="110485477"
Received: from unknown (HELO ubik) ([10.237.72.184])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 23:41:05 -0800
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho
 de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers
 <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Liang,
 Kan" <kan.liang@linux.intel.com>, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH] perf/core: move all of the pmu devices into their own
 location
In-Reply-To: <2025020304-chip-trench-4e56@gregkh>
References: <2025020304-chip-trench-4e56@gregkh>
Date: Tue, 04 Feb 2025 09:41:03 +0200
Message-ID: <87pljyyx68.fsf@ubik.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> In sysfs, for some reason, all pmu devices seem to show up in the "root"
> of /sys/devices/ making for a confusing mess as these devices are not
> really at the root of the system at all.
>
> Create a fake root devices, "pmu_bus" and place them all under there if
> they do not already have a parent device set, cleaning up sysfs to look
> more sane.

Yeah, so what happens to the userspace that uses them via /sys/devices/*
directly? Even I have scripts that do that.

Regards,
--
Alex
