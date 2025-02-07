Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA65195FE5;
	Fri,  7 Feb 2025 21:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738962377; cv=none; b=LVKIU0gQP4bmm/ZGsUmDG+tTp3tygEcE9n+9xwEBI053r1yqmfYzMAdk0clCf1c84KgefvCklx1Z+C1g76PPRIC8HV3Jrk20oI/VNQlvc5QkoQRufRU6uQ9oHivR3j6ruQxd6JLaHOF78SUyRH1B9HTUTPz0k4+Sc9sOvKj2OAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738962377; c=relaxed/simple;
	bh=CWHgdZOppLmmnI46ZiNcfojftqw4NwN4AdkDsU0kazE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLPNfOccAvpOSEqlyIf1Jt11WP+Np3TNA9X8PQjWL3N2WQwxmgIelptQRK3bDkPBHIAKjlTCio7Y6K+FIbgb31/EFckOgfGEPb3HkzrQelE7TpJVS+xGN6EcmfmQcfod8DF1biP8VStj15LeeuNwPxFqNrcQ9MAzgMZc6zAz0rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lA9CadGx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lA9CadGx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA878C4CEE2;
	Fri,  7 Feb 2025 21:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738962376;
	bh=CWHgdZOppLmmnI46ZiNcfojftqw4NwN4AdkDsU0kazE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lA9CadGxW+5SWtL6mD1Ai28l9ccyQ3Kz2ZucS0KfsHm62u1rJ2n7eeFeC24FMOwjI
	 wTGAcb+7RkzA69BG1Tu+spDhw53E0J+RZY9DW7FlZd+AJsp2WV1ZDiR5lL/xK+2nj3
	 xbkb4lrtjmoBXVAmL7HO2fYugE0b9HWlLNMjKr4AbsZzkbZLtU/y5dSTfkdZeil32X
	 PEZ8SqxRQ2cXLJONfjeyWYhuatZbgESFXbyS+MEbcaNAo/nneQEzQr38n0Pb/wbqOP
	 YcIK+H0FzkWUv8nZHPtKJcueQIX5MmN4ReYhBwk45KdsKBwoO+uTB4KtQSsZVCgbGP
	 AmANWcKa4UbVg==
Date: Fri, 7 Feb 2025 13:06:14 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v4 19/39] unwind_user/sframe: Add support for reading
 .sframe contents
Message-ID: <20250207210614.nks6bxad4jhdulwg@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <77c0d1ec143bf2a53d66c4ecb190e7e0a576fbfd.1737511963.git.jpoimboe@kernel.org>
 <b35ca3a3-8de5-4d32-8d30-d4e562f6b0de@linux.ibm.com>
 <20250204185121.jt5ylxsouqi5dyie@jpoimboe>
 <d2345191-0b73-4860-89be-9a189078d85e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d2345191-0b73-4860-89be-9a189078d85e@linux.ibm.com>

On Wed, Feb 05, 2025 at 10:47:58AM +0100, Jens Remus wrote:
> UNSAFE_GET_USER_INC(ra_off, cur, offset_size, Efault);
> 
> With offset_size=1 expands into:
> 
> __UNSAFE_GET_USER_INC(/*to=*/ra_off, /*from=*cur, /*type=*/u8, /*label=*/Efault);
> 
> Expands into:
> 
> {
> 	u8 __to;
> 	unsafe_get_user(__to, (u8 __user *)cur, Efault);
> 	cur += sizeof(__to);
> 	ra_off = (typeof(ra_off))__to;
> }
> 
> The issue is that on the last line __to is u8 instead of s8 and thus
> u8 gets casted to s32, which is performed without sign extension.  __to
> would need to be s8 or get casted to s8 for sign extension to take
> place.

Ah, I get it now, thanks for spelling that out for me.

Here's what I have at the moment:

#define __UNSAFE_GET_USER_INC(to, from, type, label)			\
({									\
	type __to;							\
	unsafe_get_user(__to, (type __user *)from, label);		\
	from += sizeof(__to);						\
	to = __to;							\
})

#define __UNSAFE_GET_USER_INC(to, from, size, label, u_or_s)		\
({									\
	switch (size) {							\
	case 1:								\
		__UNSAFE_GET_USER_INC(to, from, u_or_s##8, label);	\
		break;							\
	case 2:								\
		__UNSAFE_GET_USER_INC(to, from, u_or_s##16, label);	\
		break;							\
	case 4:								\
		__UNSAFE_GET_USER_INC(to, from, u_or_s##32, label);	\
		break;							\
	default:							\
		dbg_sec_uaccess("%d: bad unsafe_get_user() size %u\n",	\
				__LINE__, size);			\
		return -EFAULT;						\
	}								\
})

#define UNSAFE_GET_USER_UNSIGNED_INC(to, from, size, label)		\
	__UNSAFE_GET_USER_INC(to, from, size, label, u)

#define UNSAFE_GET_USER_SIGNED_INC(to, from, size, label)		\
	__UNSAFE_GET_USER_INC(to, from, size, label, s)

#define UNSAFE_GET_USER_INC(to, from, size, label)				\
	_Generic(to,								\
		 u8:	UNSAFE_GET_USER_UNSIGNED_INC(to, from, size, label),	\
		 u16:	UNSAFE_GET_USER_UNSIGNED_INC(to, from, size, label),	\
		 u32:	UNSAFE_GET_USER_UNSIGNED_INC(to, from, size, label),	\
		 s8:	UNSAFE_GET_USER_SIGNED_INC(to, from, size, label),	\
		 s16:	UNSAFE_GET_USER_SIGNED_INC(to, from, size, label),	\
		 s32:	UNSAFE_GET_USER_SIGNED_INC(to, from, size, label))
