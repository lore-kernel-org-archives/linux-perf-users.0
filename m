Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F7B1FB4;
	Mon, 23 Dec 2024 19:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734980563; cv=none; b=GJlyDxGa0YaQXhbeJizMzYPZAlKedvjtc34ic5hxWyQMawcPSgE/KamfQGCHFNr2N6n9Tu5npEOEK/JiWkdCSuOMsk3GoDDO69RvgSwQtdLjpAo5MlDBRXqYCKKB7Arvda+YDcEXKJO+Vq2vmPX6OjINwTOAc5Qie4nDvsCA9+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734980563; c=relaxed/simple;
	bh=PzODJ0zN7Ljvzrh96HFiDbnXuQ1ILoUORPMvY4CRR4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NugdBIx/Vicx3u/JVLO/Cr7WImmmo9c2KoxbpFY1RDC2Y7nc8hUlrnfPsnaKkgchRoW9HoM1rZrMB3OLWZ/sICK06oi8xVGy2ZWiivUt8FoYUqtjjeHDqJ+BrjSBDrbTSvXOeoy68HHcUmzlzVSEcPspeuXuHS4SyCXGku98eFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4vFKE7m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4vFKE7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F12C4CED3;
	Mon, 23 Dec 2024 19:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734980562;
	bh=PzODJ0zN7Ljvzrh96HFiDbnXuQ1ILoUORPMvY4CRR4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q4vFKE7mOgWgThwFnG5F9i6oZ3FxrsV1goghgORtAMtU7tPvmG/xsVJ29XtViwrt3
	 lYH4hE/JRXnvHDmsl7kk+GhPTQiaLvRUNihWi9MK1qHBT2modCszzpSzZzAwpAqjDR
	 l1zsDnv0BM+Ow3wgdlNV9UapX/dXh/jy1syPLWb4z8Zawi24en3qx6bAylBB9bojz2
	 SE0ecxxW7lEHK38QHmsNnT3JMySZnMgB63uJgIIU+jIDmKck01yMJg2LRWMilbtSoP
	 NVIFoTTS/zv/pOTbjyr7GoPHuNzoZ5db8Xfq+2vh80gQBJnA8gV00U6THqTGGd/ZWm
	 vztL8qqdWMfmQ==
Date: Mon, 23 Dec 2024 16:02:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] perf trace: Add more tests for BTF-augmented perf
 trace
Message-ID: <Z2mzzytPOpjF0Hxe@x1>
References: <20241215190712.787847-1-howardchu95@gmail.com>
 <Z2CGdi5xpJy6C6sv@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2CGdi5xpJy6C6sv@google.com>

On Mon, Dec 16, 2024 at 11:58:46AM -0800, Namhyung Kim wrote:
> On Sun, Dec 15, 2024 at 11:07:09AM -0800, Howard Chu wrote:
> > Changes in v4:
> >  - Use if -f to check the existence of vmlinux BTF, and exit if it
> >    doesn't, so trace_test_string will not overwrite $err, and keep
> >    running the test.
> > 
> > Changes in v3:
> >  - Add vmlinux BTF check, and skip the tests if it doesn't exist
> > 
> > v1, v2:
> > 
> > The previous version of the perf trace BTF general augmentation tests
> > didn't pass Shellcheck (thanks to Arnaldo Carvalho de Melo
> > <acme@kernel.org> for pointing this out), this version uses bash instead
> > of POSIX shell to pass Shellcheck.
> > 
> > This patch series also adds documentation for the new option
> > --force-btf, which is used in the tests.
> > 
> > Link: https://lore.kernel.org/linux-perf-users/Zt9yiQq-n-W6I274@x1/
> > 
> > Howard Chu (2):
> >   perf trace: Add tests for BTF general augmentation
> >   perf docs: Add documentation for --force-btf option
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next,

- Arnaldo
