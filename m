Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EF62F7AC1
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781089198; cv=none; b=G+4sl9zID21ja9yqbexHxlQKu+V6WoGaWYrV3bSDXJ20UhkRfgMBNJ3ofGAIh336B0fnAZbFIEVKl8L6ogy7rdGxxMyj8YmLYM0vFR8/QKsMNSTcgKYuFdmuF+1UMuYmK3DrRJp5yFvfseM12PfmArMpGuiy4I6Dk+ylJgjnAZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781089198; c=relaxed/simple;
	bh=kZgLQyruQ3yGhLzzzMYqMjMSV9w1jivZrkGcTRnQufw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+qiDh5WRLGJOPyVXUdw7NdK/x1XVdUH9Ao32QQmePjpdA0OMQ0egJIl12ryXifsSTg8Xx5TeApw8XpGTatSSwlmTZ7kUxApa4fhUjkAi+v9GLZ9IhLxhlhMO89RXmcyUPapC9uJKiKgzn3N+bNpMgmJVx+IxdeDSf1xO6jxCHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cnJS4avN; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cnJS4avN"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78AB62574;
	Wed, 10 Jun 2026 03:59:50 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BA243FDE2;
	Wed, 10 Jun 2026 03:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781089195; bh=kZgLQyruQ3yGhLzzzMYqMjMSV9w1jivZrkGcTRnQufw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cnJS4avNlwhIggsT3fY5wm0SxpnLPJ0UhI0mwQpkmQKvkiO1mDyhRW6RmxiBp6ueS
	 naXFibO7BqMYazZc9LmVGoHmCZHogckMKEQgKETayen+AAg+PB/rEcS7SitXkNJLx+
	 Be36IdGbVOoCPfPOZNmzRw8DNeiLJBzpPH4HLwiU=
Date: Wed, 10 Jun 2026 11:59:51 +0100
From: Leo Yan <leo.yan@arm.com>
To: "john.song" <john.song@ucloud.cn>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>,
	acme <acme@kernel.org>, peterz <peterz@infradead.org>,
	namhyung <namhyung@kernel.org>,
	"john.g.garry" <john.g.garry@oracle.com>, will <will@kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] perf: arm64: Replace symlink with actual file for
 syscall_64.tbl
Message-ID: <20260610105951.GU101133@e132581.arm.com>
References: <AHMAuwBaMCb7DmUcFDGOhqrg.1.1781071552750.Hmail.john.song@ucloud.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AHMAuwBaMCb7DmUcFDGOhqrg.1.1781071552750.Hmail.john.song@ucloud.cn>

On Wed, Jun 10, 2026 at 02:05:52PM +0800, john.song wrote:

[...]

> The file tools/perf/arch/arm64/entry/syscalls/syscall_64.tbl is a
> symbolic link pointing to ../../../../../scripts/syscall.tbl.
> 
> This causes build failures in environments where the source tree is
> copied to a different location, such as RPM buildroots, where relative
> symlinks may become invalid.

What command did you use to copy it to a different location?

Could you confirm whether you can reproduce the issue using
"make perf-tarxz-src-pkg"?

Thanks,
Leo
