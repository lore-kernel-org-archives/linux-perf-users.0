Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A780F35294E
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 23:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789430201; cv=none; b=I/WExkmKHYrv90koUTD5x719lnkMUsc8aJl+2Ts/du3xOJU9aySJ0oS2UlPnc6KU1bh7TqSC21HgMOa0usyonUA1dCp/c0IYB8Cw4W5kZPTyMtH+Xk/jWfmpu8FpwQPdPcnwcAzzlGzpATM28/HHFvnWnH7LorKtJ4KhDn76CNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789430201; c=relaxed/simple;
	bh=NLYYf+n54O4H0h4Xt+zLB6Dbu2ghpzSMuLrDhogbWps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I72Ng8fOvb6B2Qgwzw+WWkwk9il4bb7CfRCvYM0V4PkfEy5Lzn9Np6FjTPvGaT4IL1ABBifP13ikp8CsS8ifVBRT9DCUzwHYBmuinGBRZxAHbVxCVmn/FrtgCF1O5n4Ck3FkiV/TWhui4fMaNGXLkLiJFq+crhabRFfXx33FjPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LA0HhwSi; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LA0HhwSi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789430200; x=1820966200;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NLYYf+n54O4H0h4Xt+zLB6Dbu2ghpzSMuLrDhogbWps=;
  b=LA0HhwSiU3XzNy8QJ8JqLerPjA0bBHn/pak2S21q6ljkf71zEW0QJ61v
   M9Bhck/AOavQ9KXiJfrv7LI9B98f45XN0ZX3Wfq/Hn2aAWyQbHm/RpiGW
   fFgmH2+RzaE5mU8OCpFrlNQ6sZWpmo866nUcY4tL5dOH4OqiCoTePhDnM
   Y1P5O/RPTQlbyXwINpq0TOKA76mAyyn3MGTCKhyt345Afa2xcCz9qdfzf
   xIcNYRopsvnA+5oIGn+z7RxkxPekR2J/fISMrNxPuFJjrdKZPMPzGGjgw
   mFI22R3XnEmgtVgMQRFLRLklfbG6hqy8gpRZf5IqHSPjU/oWwDN+9D+DI
   w==;
X-CSE-ConnectionGUID: osWQgFXETTKE54eeCNjpdA==
X-CSE-MsgGUID: xmqZEqTVS1yIg4A517I9TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112556240"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="112556240"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 16:56:39 -0700
X-CSE-ConnectionGUID: ZavR2ebUSGaGcpDK+0QzMQ==
X-CSE-MsgGUID: XxnNeEVNSjO4O7PS8/nMFA==
X-ExtLoop1: 1
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 16:56:38 -0700
Message-ID: <5335ab48-bea0-4f2d-9520-c8b8efbc62b6@linux.intel.com>
Date: Tue, 15 Sep 2026 07:56:36 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v11 07/10] perf regs: Enable dumping of SIMD registers
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
References: <20260914014049.2061519-1-dapeng1.mi@linux.intel.com>
 <20260914014049.2061519-8-dapeng1.mi@linux.intel.com>
 <20260914020418.97E881F000FF@smtp.kernel.org>
 <1870044f-ab4c-4906-8f8b-c3216fb28211@linux.intel.com> <aqg9DV05lxzLKu0t@x2>
 <aqhK3K_yfdtB51Ax@x2>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aqhK3K_yfdtB51Ax@x2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/15/2026 3:28 AM, Arnaldo Carvalho de Melo wrote:
> On Mon, Sep 14, 2026 at 03:29:33PM -0300, Arnaldo Carvalho de Melo wrote:
>> On Mon, Sep 14, 2026 at 01:17:00PM +0800, Mi, Dapeng wrote:
>>> On 9/14/2026 10:04 AM, sashiko-bot@kernel.org wrote:
>>>> [Severity: Low]
>>>> Does this file need an explicit inclusion of <stdio.h>?
>>>> The perf tool can be compiled with musl libc, which enforces strict POSIX
>>>> namespace separation and does not implicitly include headers. Relying on
>>>> implicit header inclusion for printf() can cause build failures under musl.
>>> Ok, this can be fixed in a separate patch later.
>> Ok, merging it now, later you send fixes for these minor issues.
> It is now in tmp.perf-tools-next, will do the usual set of containerized
> build tests and push,

Thanks Arnaldo.  I would post the fixing patches later once this patch
series is queued. :)


>
> - Arnaldo
