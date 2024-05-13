Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EA74C81
	for <linux-perf-users@vger.kernel.org>; Mon, 13 May 2024 04:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715575226; cv=none; b=SmXuKivgWdhMRURSKuGimgLyF518uPV/UGrYjOJ64BMwvogYmdvGvNkNQ2FCtEWzZ4jmWFES8n9rSwxc6WKzsO78z1gVuCYx5QH9Ld6qWt/9GwIwk4DScl37fDbAVwV/13GGMtettPaSZiwsj7xwuelu2KbNmwJlLURHX7JC6zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715575226; c=relaxed/simple;
	bh=8TDPXB3dj46KiQl/F87mA5zVWnlNxiG7uKV5gyQQ4/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dltpz5slvE+oPrK2bVu0BomjqFY2mOwe58cmOs6o7cmy13ili5QX/U6NKoOclHlbDX8jlSI1+3Y5KmMq2HIght4VEBPjS8wWwRRJ/4ep27RL2geAiVZzh97xVDGuH485+M60PSZoFCJHF4zdQVZRw/L+OHbdCuoX28d7uSM6+Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MFO5Vhkk; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MFO5Vhkk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715575225; x=1747111225;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8TDPXB3dj46KiQl/F87mA5zVWnlNxiG7uKV5gyQQ4/w=;
  b=MFO5Vhkkb0Bk81Svdcsm2iK3pKR1EEpBdfeYw03h+jp7lp+NqfAKmgyO
   sZbV09MQdLYUYUL2wYT+M4ZEWmE34+mm8lkZk/atp523L2pkw7Tx/Er/7
   +0QKjxCfEGu9vO5yTPnoDOyaTH+9YvViNOT+k2hrzTG/57ebQzeH8+1UW
   CRVlunc3JOpRBfxY2LjDLqfXw/jG08ypG1kajzqG0V4revpqLaedjTBk6
   VfguuY0VyBBd3FhSBkCAo3xMJorL28V82WIwrhqqjXAHomDF1+18HeHna
   xbXaJj11cjYhWRd/Ie6RbVlbTnSxOP/xHAJfuPCtM3jqOYnYwELwVK/5c
   g==;
X-CSE-ConnectionGUID: QVdJctp8Rt2dSvVBU2yAQQ==
X-CSE-MsgGUID: SYmL5s3uTCWGne7oiXNl/g==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11625104"
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="11625104"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 21:40:19 -0700
X-CSE-ConnectionGUID: 6jGALwfCRD2bRTCOwx65zQ==
X-CSE-MsgGUID: 0EC+pP5KRXakASSlel8PSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="61031403"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.51.248])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 21:40:18 -0700
Message-ID: <305e0ecc-9bc1-43d9-b4cf-82deee694ed2@intel.com>
Date: Mon, 13 May 2024 07:40:15 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PING] Re: [PATCH v2] perf, script: Minimize "not reaching
 sample" for brstackinsn
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
References: <20240229161828.386397-1-ak@linux.intel.com>
 <ZjvhQbZhsda_kvy6@tassilo> <Zj4zfpmJhbXGrqRS@x1>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <Zj4zfpmJhbXGrqRS@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/05/24 17:47, Arnaldo Carvalho de Melo wrote:
> On Wed, May 08, 2024 at 01:32:01PM -0700, Andi Kleen wrote:
>> Looks like this bug fix was never applied. Ping!
> 
> There was a comment by Adrian, about adding a comment with some
> explanation, may I add that to your patch while applying it?
> 
> Adrian,
> 
> With that in may I have your Acked-by or Reviewed-by?

Yup:

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

