Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3712C2D8DD0;
	Mon, 28 Sep 2026 16:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612682; cv=none; b=XgytcdwJWI5SIakmabAiN+8sw1nBn6qsa0EccttuITaXi80NhLUg0Y+8AObMMiXK6iSlRjseULImpeVoR2bPJTvxqsXjOSjyL0CUSteRhtfLatyEkqLUmRejPcV8uCxHVmw477INhIi+esy2f6VRc8wgXxB3eWtcEQywK+chcu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612682; c=relaxed/simple;
	bh=CNiEZt+2CRo6nsFF5zaIZWL1XiigZHaPQeiNqV9YWQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fA6ioZFt2Z2kL5oExjQBEBmou51Yct1J88ThdvKh9YCWnQJmrG9be23FailtMDLGjSmvlncBtxBHpxOUnCHFZvcRs3wDHlhSSZ+Sh0w4pgWbOzGQc6bChUC8j21jZ01A6HkTRePCAn2t3/mi6ZlGA/9YbZ/aYmKPclmmVnyhywA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lxWbH6GE; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lxWbH6GE"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C58F91655;
	Mon, 28 Sep 2026 09:24:35 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C864A3F86F;
	Mon, 28 Sep 2026 09:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790612679; bh=CNiEZt+2CRo6nsFF5zaIZWL1XiigZHaPQeiNqV9YWQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lxWbH6GEGBkRUMdPhMLUToDlfyzIzCmouYTWpM4Q16JLjHoHBPxcLavr4v9E13sEe
	 GCoIbxfLikRMjVn5Adrr1aZS6ZVPqyDaF6gTHxahZ0zOs5S714+6XGU6Uo03fShSg4
	 P5n2BtQRgAYrH8/GVVpbYAsWYtm027gGz9M0tVhM=
Date: Mon, 28 Sep 2026 17:24:36 +0100
From: Leo Yan <leo.yan@arm.com>
To: John Garry <john.garry@linux.dev>
Cc: acme@kernel.org, namhyung@kernel.org, linux-perf-users@vger.kernel.org,
	will@kernel.org, james.clark@linaro.org, mike.leach@arm.com,
	leo.yan@linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update John Garry's address for from arm64
 perf tools
Message-ID: <20260928162436.GF14479@e132581.arm.com>
References: <20260928151652.66499-1-john.garry@linux.dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928151652.66499-1-john.garry@linux.dev>

On Mon, Sep 28, 2026 at 04:16:52PM +0100, John Garry wrote:
> My employer e-mail address will stop working soon and I am likely to get
> more involved in this area in future, so update my address.
> 
> Signed-off-by: John Garry <john.garry@linux.dev>

Reviewed-by: Leo Yan <leo.yan@arm.com>
