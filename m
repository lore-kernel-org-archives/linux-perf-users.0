Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7BA3399F;
	Thu, 24 Oct 2024 11:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729768573; cv=none; b=Z5wUqZ9RfotiJ0DI9a5Poygd3BCR9liinvfbdOzIO3DFNX7eUvrqsv51/PElGPxVaKwJ0lvohseb3UnWeg9YvJ9d1KOxvj3bvu8lyCO08/yhABU/9rqJHkJIadowZAvn8rTve2GVYb/8/6M4TTT7Wh29l+xWK1/ZzMm+e+98WvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729768573; c=relaxed/simple;
	bh=VINJQHQzS6kytZz2fSnKOBmP+rBAzTun7oi2xBRLVWM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VMtRmYo6q/miivEzQl0Y7UkLnwHA3XNkdIOl+WarTJEf6E4qivLmeuz87Sjx04uyKhbbn4GfVNU0F4Bz5h5jOROz5Va1+Afa7bWvRWNPnvBFgKPzVKH5mMRETNFlLPjZ3b9Z5Z1cICT/8w0KMmjlnIQN+MjtOKIqMXRh+Ak7ecY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e+EiVbWo; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e+EiVbWo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729768571; x=1761304571;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=VINJQHQzS6kytZz2fSnKOBmP+rBAzTun7oi2xBRLVWM=;
  b=e+EiVbWoY0IhvgiFVV1xuBV1BykAhfeM5TYDKnxsPE/617qsfSwr9kWA
   RaCvQXX7cacqKdWtfDLEpustGkyf4O7R8KkPO/rAHNarCIDSL4nVzRZjo
   jB2qI1S7iIAPfi0LtztU5Pu1L3ltybXfB9kYFfux/+nyHVMfFqy+tDUci
   lClribwVc50VMlGF/IJMTH9X7MtuvnsWX261o1zE6koRmDs1YVLMpAWsv
   PG1XR9Fb20+arrsEfw2iydeQ5AEby43WNcHb+ZxXIP7eRpfTKFXeQH6jc
   CNE5zhXGSpoozSvm4tbPVyHumoqCetQS/qmXKzJDfp3xP9f9VslAtvMUG
   w==;
X-CSE-ConnectionGUID: MnU5e/v4SJiVd7tjIXr+ig==
X-CSE-MsgGUID: cFtdR7R4QnKcZ6wOmIDyxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="28850339"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="28850339"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 04:16:10 -0700
X-CSE-ConnectionGUID: xNyGQUnrTdabXEUIu+R1Eg==
X-CSE-MsgGUID: v92XG2nxRDapz9VAeVQ+Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="85355046"
Received: from ubik.fi.intel.com (HELO localhost) ([10.237.72.184])
  by orviesa005.jf.intel.com with ESMTP; 24 Oct 2024 04:16:08 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Qianqiang Liu <qianqiang.liu@163.com>, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Qianqiang Liu <qianqiang.liu@163.com>, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH] perf/x86/intel/pt: Fix NULL pointer dereference in
 pt_buffer_reset_markers
In-Reply-To: <20241001082757.111385-2-qianqiang.liu@163.com>
References: <20241001082757.111385-2-qianqiang.liu@163.com>
Date: Thu, 24 Oct 2024 14:16:06 +0300
Message-ID: <87bjz9vjih.fsf@ubik.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Qianqiang Liu <qianqiang.liu@163.com> writes:

> The buf->stop_te and buf->intr_te may be NULL, so we need to check
> for NULL pointers before using them.

Iirc, this has come up before, because static analyzers get the idea
that at that point ->stop_te and ->intr_te can be NULL, but in reality,
they can't. When the buffer is created, stop_pos and intr_pos are set to
-1, which will always force ->stop_te and ->intr_te to be set the first
time around.

So no, not a bug. It might deserve a comment explaining the above logic,
so that more versions of this patch don't get generated from static
analyzers' reports.

Regards,
--
Alex
