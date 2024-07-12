Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533951741CC;
	Fri, 12 Jul 2024 16:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720802754; cv=none; b=j2UDKh43NSRiUOuC5aYVLygK6FYCd4aVVLN2aCGyd+ulc5A3qGmQKXegBKbrfr9uUtKmCGSIw69zGUDB2gJb+4Air+MUoewnwXuEbCkxWwuKlu0nxzCxjdojYtg32aYNaCQg4JNVB5ro0YbVHjKsVJF/B237YIKx+RnVV0lIl0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720802754; c=relaxed/simple;
	bh=PxP4TK+mvPN45+BTBbdqkIXyKIpzC2cqEvdudQjQECw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tS+bKcJqVgQwmFiD5nSo/XQMgKj1DW0/g2g3UED+fAGGKL9r+SmdcM8OqFl1+eh1zV6mRRelWhEdu8kbDy9ofaxCYerzKee2OqZT61UaNEF2B0KsbPZj90FZ3RpVvRXUAxLDPCyKeqvEKm3zixs8SI0toJo6ny1UWcaGtNT+WVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qfvz7uUU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qfvz7uUU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6487EC32782;
	Fri, 12 Jul 2024 16:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720802753;
	bh=PxP4TK+mvPN45+BTBbdqkIXyKIpzC2cqEvdudQjQECw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qfvz7uUUWXUVchBwueAjKNEbuScyzLKwUFxfPjr5dcYvPEk6he6jOVf0Pf0vBctuQ
	 6x03BY+IzugsHMn/b0L7kGAZBcb+9MNw3VX/FIWPEbk3K5aGQyM27t7zGbH1wC5H5n
	 +uKG+DrpFBLzuLgoig9Wh+vpi5Cf2ooUVMDr3nd3tFCrQAR1HClhHq45xmprlLRJIT
	 hBNG4aQ6dfME6IubuXvg6wnR1QGIvy+iwj3Di9eXbP4C7IvMNVG18HmEZ0sZYd43bH
	 FtFcBnY5NDqboofyrSlmaaSwUkbiH8NEYt8pWxO4IlRvh+sTJYT5igmJGTzpX708KM
	 9bYTLXOICqIBQ==
From: Namhyung Kim <namhyung@kernel.org>
To: irogers@google.com,
	Haoze Xie <royenheart@gmail.com>
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuan Tan <tanyuan@tinylab.org>
Subject: Re: [PATCH 1/1] perf record: Fix memset out-of-range error
Date: Fri, 12 Jul 2024 09:45:51 -0700
Message-ID: <172080273250.2773604.16649814239914187586.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
In-Reply-To: <11e12f171b846577cac698cd3999db3d7f6c4d03.1720372317.git.royenheart@gmail.com>
References: <cover.1720372317.git.royenheart@gmail.com> <11e12f171b846577cac698cd3999db3d7f6c4d03.1720372317.git.royenheart@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 08 Jul 2024 02:01:00 +0800, Haoze Xie wrote:

> Modified the object of 'memset' from '&lost.lost' to '&lost' in
> record__read_lost_samples. This allows 'memset' to access memory properly
> without causing out-of-bounds problems.
> 
> The problems got from builtin-record.c are:
> 
> In file included from /usr/include/string.h:495,
>                  from util/parse-events.h:13,
>                  from builtin-record.c:14:
> In function 'memset',
>     inlined from 'record__read_lost_samples' at
>     builtin-record.c:1958:6,
>     inlined from '__cmd_record.constprop' at builtin-record.c:2817:2:
> /usr/include/x86_64-linux-gnu/bits/string_fortified.h:71:10: error:
> '__builtin_memset' offset [17, 64] from the object at 'lost' is out
> of the bounds of referenced subobject 'lost' with type
> 'struct perf_record_lost_samples' at offset 0 [-Werror=array-bounds]
> 71|return __builtin___memset_chk (__dest,__ch,__len,__bos0 (__dest));
>   |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
