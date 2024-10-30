Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D8B85931;
	Wed, 30 Oct 2024 07:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730273238; cv=none; b=F3217uJtck8JWZho6ct4Z6PPoEv8MlDVc81K9qkHkblNb701SpQBSdaPw3YV00JgZaD40IYhzWso0EhXFZJiJllJdHpwbJEl+Es2PtIM/dRTeQPJyG0Kaf91zJ5PDDndE5O2YS533Pnnw2N9WmNWr19EvGd/RzajRwsySZTLNuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730273238; c=relaxed/simple;
	bh=vGKU/9JKhIPRunU2sozlJwZTP3bFyVs8KZfKBAD/Evo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IzFUHVVUoU46snSa8Nm1Cr2qXGw0obgtpj8c+nv0UCueWFCcyk/9m0PZFpZTAS1G5cPCrDIAGpjxdskb5u4FtnGMc9UPtgjQZPw9Fsw2Q6vEg8QsIT/RSNsCIqTsoDidgrI2DiWtfEUtC4Um/z3jb3FtqqPy94j4zbu32RsZCDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aZzOrWS4; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aZzOrWS4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730273236; x=1761809236;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=vGKU/9JKhIPRunU2sozlJwZTP3bFyVs8KZfKBAD/Evo=;
  b=aZzOrWS47uaYqWgaeFuBoFHBAjphsk9AACCGMbB7RO7C3OGTuiqTW+tq
   kYAhSNknvIywTJfu3hIjfMzPJmtDrls80rWybJ1qtmvB50DxIjpTG/+cI
   GFWmRd4dnmUOJCv1/w9bCTC1+n8tk82ZfLRr6WYLHOVH87eVd5kfAmm6m
   p1CK/cdQ+Rd0unyW/FuAhU1nA38wOCu0YouL6dlPtF6B6+9OWAAs9Fe+1
   zOg0BYGXl07CWikwAXQuyVWcdz7jOYBIK65b9h2IQkyyhJaF3zgW6URr/
   bmjSy9AbwGbt7Xn/Bur0nE+XTJHGTIlj0ueGWaHvAPZk7mLwTTR7Gimw6
   A==;
X-CSE-ConnectionGUID: HGu36LyMTyip0yVZ6h6edQ==
X-CSE-MsgGUID: iEtchNlgSQy4TZE/x7SDpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="32798747"
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="32798747"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 00:27:02 -0700
X-CSE-ConnectionGUID: bryCe69USaeq6F6tP2Y8ZQ==
X-CSE-MsgGUID: yxn/g556S2mCbJnJKJ7oFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="87359263"
Received: from ubik.fi.intel.com (HELO localhost) ([10.237.72.184])
  by orviesa004.jf.intel.com with ESMTP; 30 Oct 2024 00:26:56 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Li RongQing <lirongqing@baidu.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhiquan1.li@intel.com, alexander.shishkin@linux.intel.com
Cc: Li RongQing <lirongqing@baidu.com>
Subject: Re: [PATCH] perf/x86/intel/bts: allocate bts_ctx only if necessary
In-Reply-To: <20241030063521.4025-1-lirongqing@baidu.com>
References: <20241030063521.4025-1-lirongqing@baidu.com>
Date: Wed, 30 Oct 2024 09:26:55 +0200
Message-ID: <87msimt5j4.fsf@ubik.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Li RongQing <lirongqing@baidu.com> writes:

> Avoid unnecessary per-CPU memory allocation on unsupported CPUs,
> this can save 12K memory for every CPU

Looks reasonable, but have you tested it? This driver is in serious
danger of bitrot ever since KPTI. It might save even more if we simply
remove the whole thing.

Regards,
--
Alex
