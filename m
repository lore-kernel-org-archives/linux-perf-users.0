Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB683112AB;
	Sat, 28 Feb 2026 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772297407; cv=none; b=R7RbRxWj6//2bte62v89/9ZKOF4bTm6dVXgDoE2l+QLNFmRlxehqyr3hxiqKtBppTKTjTiEIbnzvCqhoPKmZThMzoVdgJf09oOrffYZN9jLU3fV8o9SmpQWQoCA04mnxAaBPM9XA1ZwKvwbrjS65K1Zhk+yjZmDu069CYGWVfak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772297407; c=relaxed/simple;
	bh=EKQhU9MFTHfsLUytyRShr1nIh18ZLFNPpAoVEawueIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hn4ZzJsIlPHE45HTD+KA/wjZ+ZyyajH68RqrMlHw6KKj7cM1JzYNRfFKXe341k37GiGD/FhwJmn7wbivITnTFOU/MpqvYLuwxN3zRy+BcrWGlOPq2FacvgGuDgiEj48DHHQbdtdAjWXmO631uH05EeuU68pYVdo/sAs90NWjOjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYw9u4Jy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYw9u4Jy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45306C116D0;
	Sat, 28 Feb 2026 16:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772297407;
	bh=EKQhU9MFTHfsLUytyRShr1nIh18ZLFNPpAoVEawueIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FYw9u4JyY6IrjZ+viPaZhpv445h12H08bmsKim9gDxQEEoQBx1U/lWp+6b2wsU7VY
	 /J2vJyAfpJTNB1U+Fu66WudIsqY6Pu51sgPNtYLjNThG4MhY4d0cmCh8PGbhTAliE7
	 hIezCvoesoIVE6+xRk5gSX8tCRdr7ESRj92vazq8WMApe20OPqUZkj367zixcGYMrg
	 iXcwnX33D7XigvEo5XXl7wzg6mtV3bD/FFmz2q/Qfd9mjZ5b9zJsUIOxZI+gjguYJF
	 /wdgME4lFkmzdiT4CSFba0bE78J276XhXpsTTKJ6Uu/5Hz/cSHcfASvav0Ov6OoqNG
	 2IyKmtuqiDysA==
From: SeongJae Park <sj@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/events: Replace READ_ONCE() with standard pgtable accessors
Date: Sat, 28 Feb 2026 08:49:58 -0800
Message-ID: <20260228164959.39672-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260227062744.2215491-1-anshuman.khandual@arm.com>
References: 
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 27 Feb 2026 06:27:44 +0000 Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> Replace raw READ_ONCE() dereferences of pgtable entries with corresponding
> standard page table accessors pxdp_get() in perf_get_pgtable_size(). These
> accessors default to READ_ONCE() on platforms that don't override them. So
> there is no functional change on such platforms.
> 
> However arm64 platform is being extended to support 128 bit page tables via
> a new architecture feature i.e FEAT_D128 in which case READ_ONCE() will not
> provide required single copy atomic access for 128 bit page table entries.
> Although pxdp_get() accessors can later be overridden on arm64 platform to
> extend required single copy atomicity support on 128 bit entries.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
