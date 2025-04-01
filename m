Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0880202F67;
	Tue,  1 Apr 2025 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743517220; cv=none; b=R+IM7A3XU7W7dLfUjhfCgeuJ2E+ycmQ1fnsHt1j/tTyxnHtMdAq4pXqLla8OBwod87P25UL69UPjgOOSzhiOa1HAkxP9Wn+sEOsMgiZGBfk6m9YRcR6iIWggTVLcFlprJB6Vd5pOJ3HkZsgXwnqv6Posn8f7nv99nsaduTOLhvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743517220; c=relaxed/simple;
	bh=mRIBKcBVbGppx74YoEbo3iWRgTc8Hy63ntijK5V2KcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/fVXItgQDtif6a30wyZxF9VFEdSnIDI0vMVpaX+cfp5V/lNeLHQFh0XcBGQ0bU1eJm3hKrD+UN3Cj+9D2/nM8trVhbsfkgKof766AOA2bJYNhg1+q+ut2BQqcnngAie6n3cn8sJf/amN2xR3qiyn/m7KdnkUw3VKFgQPSPC+qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Amg8tzAj; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Amg8tzAj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BbOt8uPg4MQ5ULTpBSXlv+eys0/YbsgiMNxX/LarGTQ=; b=Amg8tzAjZSvGLYXW3j8wk4gcxF
	IG+dUXapqgDFQkVq14akqVm3zJrRIdUBngzfGDXCFBlJlpw3ji/m9DmiE9IlT4O7BzQw437DD8x6T
	jX5uM9l4Iw95c5/LNuPKtys5qqHYOcCfoBMz09ieNBlvH7rQDpDaWelu+G7Bl2oLKQFBZtgXOZ4kW
	tHE+E+PeMzGkZbCgwLHadLpCnN8ajLwgrbPoYs+AAPf+Lpuj1SKmBUqw5nKsjHhQRU5iYv7UswSVs
	CNwPo6DAv3UMpNqu01U02LCHKxkK4AuSbgF+27zBVY5XXA6uyLfxw5AJbYBfQmbmgYNHQSfddQn/A
	QVN0arVQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzcTG-00000006pW2-3wd7;
	Tue, 01 Apr 2025 14:20:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6384830049D; Tue,  1 Apr 2025 16:20:06 +0200 (CEST)
Date: Tue, 1 Apr 2025 16:20:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86: Rename bts_buffer variables and use
 struct_size()
Message-ID: <20250401142006.GF5880@noisy.programming.kicks-ass.net>
References: <20250331122938.1837255-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331122938.1837255-2-thorsten.blum@linux.dev>

On Mon, Mar 31, 2025 at 02:29:38PM +0200, Thorsten Blum wrote:
> Rename struct bts_buffer objects from 'buf' to 'bb' to improve the
> readability when accessing the structure's 'buf' member. For example,
> 'buf->buf[]' becomes 'bb->buf[]'.
> 
> Use struct_size() to calculate the number of bytes to allocate for a new
> bts_buffer. Compared to offsetof(), struct_size() provides additional
> compile-time checks (e.g., __must_be_array()).
> 
> Indent line 327 using tabs to silence a checkpatch warning.
> 
> No functional changes intended.

This is two things, as such should be two patches. Also, meh. This is
going to create extra work for the arch-pebs guys I suppose.
