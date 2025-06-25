Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E58325C6EF;
	Wed, 25 Jun 2025 18:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750874684; cv=none; b=eUcI/m/lhA+X+yWu0tYDRCw8c9yWKJvqz4SNDViv48mKnUC/s/ES/PCFBWtHZ/swHtq3j/m8Ge4qAvaAtgWGWlvYAoyXrJkma2EGjraYG5qzq31VFBMFyaMh+Lr9dUlOvgsivEqLx35jgbHvA5GBcW+bugyW9+Zi6Jstcw8Clqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750874684; c=relaxed/simple;
	bh=7ElKojLUY1hlk4dpK/k4BRcYnZ+0+AsGYLK8uW6RCXg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DtBgPnv2OSsRFD7m3PbsmPtpq6DuaItAp+1UASS/Cfc+GaLG63ZM+e5U9tijRoKrJ/UoFw0hIhonjxcw8JRSxutRh3fpL9AumQ5aaD4a/pMUTPkV4oO4qk7UCzx49TWaloaKLl+eDBc1Le3oDQMgiVnA9u/tDzikev1zUs2OAoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uubrlqZA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uubrlqZA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DACCC4CEEA;
	Wed, 25 Jun 2025 18:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750874683;
	bh=7ElKojLUY1hlk4dpK/k4BRcYnZ+0+AsGYLK8uW6RCXg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uubrlqZAWqFszszqQWtHOSSMyY6zkLFVShQd22BKlMJ+IXWf6+q/UcQx2ucmiiNOl
	 KHx27k5zbnSGc5q7F6vI8EhmMXYJsSqryxqTWdRPvUoxnpS63I8fyoAeqfop/M5VjX
	 QI+DE0X/Fa7tGvH7+KCiWkBrECE6YcmB+c13Pb2zc0Df77LcVKEXqzENeLADa1Jqoc
	 vHYBrVf4gOWva4dUqES3ayY1cCVN4xI4XE1VGhdTJcnIsKAe46kD8yMvdmKAuXgsxv
	 fHf7CJIi/qClUiaMCLe7/T7vlSQsCycevnxk/Az1UmBap2jLse+65HeMyoA1wf72G7
	 KDYfKJvM9Y17Q==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-kernel@vger.kernel.org, Chun-Tse Shao <ctshao@google.com>
Cc: wy.shih90@gmail.com, Ian Rogers <irogers@google.com>, 
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 adrian.hunter@intel.com, kan.liang@linux.intel.com, james.clark@linaro.org, 
 tmricht@linux.ibm.com, leo.yan@arm.com, atrajeev@linux.vnet.ibm.com, 
 linux-perf-users@vger.kernel.org
In-Reply-To: <20250620174034.819894-1-ctshao@google.com>
References: <20250620174034.819894-1-ctshao@google.com>
Subject: Re: [PATCH v1] perf test: Replace grep perl regexp with awk
Message-Id: <175087468332.1361639.7789404923803499245.b4-ty@kernel.org>
Date: Wed, 25 Jun 2025 11:04:43 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 20 Jun 2025 10:40:09 -0700, Chun-Tse Shao wrote:
> perl is not universal on all machines and should be replaced with awk,
> which is much more common.
> 
> Before:
>   $ perf test "probe libc's inet_pton & backtrace it with ping" -v
>   --- start ---
>   test child forked, pid 145431
>   grep: Perl matching not supported in a --disable-perl-regexp build
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


