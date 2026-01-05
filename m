Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9600830E831;
	Mon,  5 Jan 2026 22:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767653952; cv=none; b=c7mjp7JXGmMRI7AOmUW9Ea+0sxjPmUPFDe2Dik7Gw8SONHrsr6aXUL9IXPsx7RhQ18KDuYPUaIPm+Tg3aeuSf7hozB9hbdhPOxuGAKwCTCPkXlStx69nTi8/ZuuWSI2EHgCTZTJ4m/b7cxXPYdhxY0ia5qrXKrYL6hfFwtCWAoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767653952; c=relaxed/simple;
	bh=MEkyDErUS6Fel9lwzIrHo9OgWUdBuOYVWyJEsTcqV2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=En05inT9mKBuTUEH0YUosgg2qrab/ZEEmMuNmiKN5v0/YoDcdRhH3yyJSBplbjB4TxUHpQJ+c4ZS8mZRgat+ev2WlQMhokrzERiu5K2QPa9JSxYmRoPJLSYK60EXF/KHrNbCr7oWEM+qSrPGwwAa34Ob+MC+1rLmENSF5+hJMLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/e27yM1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/e27yM1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F616C116D0;
	Mon,  5 Jan 2026 22:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767653952;
	bh=MEkyDErUS6Fel9lwzIrHo9OgWUdBuOYVWyJEsTcqV2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B/e27yM1Uo+eqLH3XgQ5mzZZQgzs5xG8DfsjcQbKX9v+IzN0VMu//p3EiYm7SugTk
	 N4YOnEVUMNX5Z71ZhVhv2OVglKZQjcFb6VQcApg5LpRbnMEXqvSebw9GvmM5LTuy87
	 zG5E251p0BvG/B+EGgGf/5/LA4M5Odom8s088SyCguToJfGF2dJQyHEbwg8HI3eySY
	 JFS1t/Vo1q2JvaTV34z/4ybnN99ilSUSDfHoCznH2bI879hEy+1CL/5jn6nrC4vthr
	 cHZp0bxJz9FdtRNBPuTKlWWly1QVhNwUpm4N8h60Q+D3SU16esUqjFCndwqMhNYXqK
	 DJa+kOKEE0BBA==
From: Will Deacon <will@kernel.org>
To: Atish Patra <atish.patra@linux.dev>,
	Anup Patel <anup@brainfault.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH] drivers: perf: use bitmap_empty() where appropriate
Date: Mon,  5 Jan 2026 22:58:30 +0000
Message-ID: <176764558097.1441586.5364156428350110916.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251216012004.341288-1-yury.norov@gmail.com>
References: <20251216012004.341288-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 15 Dec 2025 20:20:03 -0500, Yury Norov (NVIDIA) wrote:
> bitmap_empty() is more verbose and efficient, as it stops traversing
> bitmaps as soon as the 1st set bit found.
> 
> Switch perf code to using bitmap_empty() where appropriate, and
> correspondingly use boolean types.
> 
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] drivers: perf: use bitmap_empty() where appropriate
      https://git.kernel.org/will/c/0c7c64146f70

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
