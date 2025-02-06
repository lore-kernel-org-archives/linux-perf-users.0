Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9BE1A0BF1;
	Thu,  6 Feb 2025 19:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738868864; cv=none; b=EukeelghDN6j0j+9ns0w3LBpHZhvzsWb5G+qByyBkU4Wpdx6c6EiGRWjGkNM/F7edv6lqSXURV5hKF2aB4Ek1Bp6RNz+2aPLETBjNFtE7QrM0ClUZbIAVTrK8XoSvYqkp9wYnUGE/B2C4b8qIrWSprpNOOD8u92Z4YzQdvY6Kn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738868864; c=relaxed/simple;
	bh=MNWow5mx11PquQUfbuya0MNama+0GK4GRbwthrGkVhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1Ap+qbESkjV307je62V2CN0Su5ELqhkubtf8eNYXcvzSKv3/uwD6Gh4t9GS8OsTJQDw8+lGLlhClLTdbFBcY6Lq8+AjFFwiajcY2+4tzn+cA0f+UptGZEFz6t3OJsss+ErcLAKZle6CZ90+tQ/iDYa6e+DktuXf/yA/FMVOK8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L9zdvFZ2; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L9zdvFZ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738868863; x=1770404863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MNWow5mx11PquQUfbuya0MNama+0GK4GRbwthrGkVhQ=;
  b=L9zdvFZ2FPDJ/sRq+mNj92tkcYe898CVda2tVS3gKsTM0a3fF7sRZUOf
   hQhljhGvlVi6zpPRG0oqyPs86ZZUgDnXz96qgYAX71dbcg9Mtghidn2iu
   LZ6HQcqV+4piwf0HdXzjDulifiyQNFM+E6qp55nkXHQHPkTsMnxAU02SI
   dUaPHsvgruLWSvZ4vMskqR7gGQuZnNNizaoIr4NEelWE6IZeFp2tv0wyq
   oyZGlDnhMFLECmF/U/1T2I76YKYp/ZdD7CyLL3ml/yvpsTs3UtKZPcwzH
   ibcPMDa3vnqrvD8UTu/6M2CLGLNpko2ggaP/+MyM5kUQmLplX7DteThL5
   A==;
X-CSE-ConnectionGUID: FBmVP9t/Q2202zgn7zBjmQ==
X-CSE-MsgGUID: X2fquCKNRt+v07Z7vKW/Ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39396573"
X-IronPort-AV: E=Sophos;i="6.13,265,1732608000"; 
   d="scan'208";a="39396573"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 11:07:43 -0800
X-CSE-ConnectionGUID: iT+Fvi45S+GvVWoihdjGOA==
X-CSE-MsgGUID: wRD8zl5mQNa5ZGRalZRZHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111158272"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 11:07:42 -0800
Date: Thu, 6 Feb 2025 11:07:38 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: namhyung@kernel.org, irogers@google.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v5 0/8] perf report: Add latency and parallelism profiling
Message-ID: <Z6UIeujfV1lHOF0Z@tassilo>
References: <cover.1738772628.git.dvyukov@google.com>
 <87ldujkjsi.fsf@linux.intel.com>
 <CACT4Y+aVWH6d7kuxzvcJSarXMQB-PPDTcE5OvN2tjkOLnzmMLg@mail.gmail.com>
 <Z6UGJuL5e5WQQL-M@tassilo>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6UGJuL5e5WQQL-M@tassilo>

> > Also how do I run tests? I failed to figure it out.
> 
> Just "perf test"

Or actually did you mean you can't run it in the build directory?

For that you may need my patch  
https://lore.kernel.org/linux-perf-users/20240813213651.1057362-2-ak@linux.intel.com/

(sadly it's still not applied)

-Andi
