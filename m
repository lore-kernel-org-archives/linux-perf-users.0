Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450083B38BE;
	Sun,  2 Aug 2026 12:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785672791; cv=none; b=ZTcusiXMN8+ya21EimvaPFiOTmqTI0wLicHxt6RvdbULYWX5e04X6Zvilgv6uhTMayqbbx05QHM927latukX9NpJk1y7o+hz9OFLnJvymmuyoanYc8m1qtLeGMZrcEGz3sz+v+SECknRZ4DkzAWGL49zfSE7A1Q0ljpnWJLJxUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785672791; c=relaxed/simple;
	bh=E/cdMvj75FbwXT20aijaNacdbnll/H/2vJgOWV8ES9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FcS6s6cvTKd8Xntrt+CReg/RfY4XysQG8+ep3L2uDEEfP7dpqPrrNggSxCCqPzWbZtBWd4HfOt8JIxypbgXmWwgwodDuqLSDHlsQyQQg7bH6zPY4a0vClFvsb8Zmk5AE5poQdnh4xxVWhQSWju3g+SQvB5Igco+jY+78lAQMtx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/BIDdBh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/BIDdBh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BC51F000E9;
	Sun,  2 Aug 2026 12:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785672790;
	bh=8NzEz/L4MaCMQSAHBHYHb2gFB0rRQPncj/WkeDZonM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G/BIDdBhh0jGS83ufomQbqpih8WuyrfX9n7eXd3xEdA0uOxw//ZTMdapaH9k1LYIa
	 Le0ZlCvDaRNtOpRbwTuemJeSKgKOgqNS5MjM431wZWRxFt4YDMOzvnVD1WjttqQN5W
	 NPKsrYiUGkAK6Pui+WkOB7KdxEEOecISKGn30xse+6MrHqEaHBdB2yiBRpwv9YfYaF
	 oeLmZVjlYsJmZSS1bq3P7AVVm2no0/Eu0JqM0kuUr4ZCa8sNUqpvNs1UXW0DlCQsQN
	 +eIUrgon8lpdEjW9nd87x8qhzqBBkxUYYKfdxqSrILl6NInPJ22AXNYbJ810E/oB3l
	 7UNhE9HNilGgQ==
From: Will Deacon <will@kernel.org>
To: mark.rutland@arm.com,
	catalin.marinas@arm.com,
	Robin Murphy <robin.murphy@arm.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	ilkka@os.amperecomputing.com,
	bwicaksono@nvidia.com,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 0/4] perf/arm_cspmu: Miscellaneous improvements
Date: Sun,  2 Aug 2026 13:12:29 +0100
Message-ID: <178566825175.1853083.11515494641516544186.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1784213435.git.robin.murphy@arm.com>
References: <cover.1784213435.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 16 Jul 2026 15:56:33 +0100, Robin Murphy wrote:
> These are a few quality-of-life improvements for CoreSight PMU that
> I've accumulated based on things which have come up in practical usage.
> There's no real dependency between any of the individual patches, it
> just felt right to send them as a series.
> 
> v1: https://lore.kernel.org/linux-perf-users/cover.1783605641.git.robin.murphy@arm.com/
> v2: Fix valid nits from Sashiko review, add Ilkka's R-b.
> 
> [...]

Applied to arm64 (for-next/perf), thanks!

[1/4] ACPI/APMT: Use stable device ID
      https://git.kernel.org/arm64/c/04aa909b38bf
[2/4] perf/arm_cspmu: Improve APMT-based PMU naming
      https://git.kernel.org/arm64/c/745a724f9c81
[3/4] perf/arm_cspmu: Improve sub-module error reporting
      https://git.kernel.org/arm64/c/60b234db6bf1
[4/4] perf/arm_cspmu: Make IRQ more optional
      https://git.kernel.org/arm64/c/36e200f01991

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
