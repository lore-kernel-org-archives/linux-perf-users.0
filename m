Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E221477999;
	Thu,  6 Aug 2026 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033067; cv=none; b=Z6f3yEwhACVAbtzoD6c8DDCPCm9YTG+d5RD0QqOQ9wF0EfjEeMwhKM5cf+feXFabskMUYTWGIC7M7+V2bL1R982v6TA/xbHJeckzkus7P1arrOe1OP0hgPmRESUke4gly32dHi056MJCpnlssXoZAoVWULkQ6XarvvqCtooIn90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033067; c=relaxed/simple;
	bh=+Lsa3aMiTzKAE5g3aa/F5/P/Pmez2hMftZ8LZa/55gg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Pk0Kq8Sn7IbkWChjMH0Jof7aENkjQ0+DmLpBiuAPjVtqV75BpX99ZhTSlkLs2+onS2CUt2lfNx/mXTMoGUR72C6kKHNdbSIjGn5eJiUtge7KDKciuqTsEDTJr7Wci6/Yz1/nOUuxz1ILXAAw/urCmlT22Tv7/JXpLZowIxZTl10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nntAzZ28; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nntAzZ28"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7C81F00A3A;
	Thu,  6 Aug 2026 16:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786033061;
	bh=EQue+Dizrs+j+g5A24gZYRYdbPJgq+Mm4GmojRtEFlI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=nntAzZ287hIfhW9q/UNxqhFo66HjrgYW+n6UIcBxZNY8mHBVWx/cLpBD0APpic3bB
	 umvkMK/z0FkCn3UDRptxJ12nQ7IEbE4WwdSBtb9EMSy94tJh6mfWQqkErpJpaWnoBD
	 6DXs1Nsk7CRV9Gsg8o7oGEWq49GL4v3FgGxbILasTbcqmrdvzxEXGpwlLEsEoyN7tc
	 7j4EKP+NAHsKdd6kEeWVbYrY6pNDPuC5C6qxR/VVZodqdJAbUx/GhvvpbvsNirM3bY
	 Y+cUriuuqtcZHo3daudauTQhiIEKVX8levaNUbxC/X112v+irqhbT7Ve1CvaI8OK+6
	 UXx4g4sW3ITCA==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, Ian Rogers <irogers@google.com>
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 mingo@redhat.com, peterz@infradead.org, ravi.bangoria@amd.com, 
 swapnil.sapkal@amd.com
In-Reply-To: <20260721235254.294053-1-irogers@google.com>
References: <20260721230952.267754-1-irogers@google.com>
 <20260721235254.294053-1-irogers@google.com>
Subject: Re: [PATCH v7 0/5] perf: Fix and optimize maps parsing,
 boundaries, and bounds safety
Message-Id: <178603306154.1984988.15161799748169880025.b4-ty@kernel.org>
Date: Thu, 06 Aug 2026 09:17:41 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 21 Jul 2026 16:52:49 -0700, Ian Rogers wrote:
> It turns out that PATH_MAX is respected by system calls but isn't
> respected by file paths in /proc/pid/maps and /proc/pid/smaps. In the
> kernel "//toolong" is placed in the filename of mmap/mmap2 events
> where the filename is longer than PATH_MAX, do the same in the
> mmap/mmap2 synthesis code to avoid overrunning the event buffer -
> note, the filename buffer is bounds checked but this makes the
> synthesis more similar to the kernel approach. With Gemini's help try
> to address other correctness and overrun issues.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


