Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E626F166F32;
	Tue,  4 Feb 2025 18:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738695085; cv=none; b=KJhIqiiNlcUPaWpipKrW0e/7aUoZdptrnse5m2ellrjpDuLGSL1MfKcp77cNMggBbwyMugAn4kPngFgQrS4e47f7n0+OW97hSsLPLqQVImyJACkxgoDx8r4T5NASukm2kug3jq3l90QNXamvUwm7K6dJPNMd+fPGBFIC5K3cPns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738695085; c=relaxed/simple;
	bh=deW8O4qvXwa72p0wEVgLCyS0TJzJuu4g79u6uEqpCZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lE5LvjRHf3bncOT4UU8yuDUA3wfRFWpeS/hV41oQs1HdKQQhITTPaD72/NhUbz8bIVDOO2e0BKfASX6P/VEDXSFM0eCyFM52C/a+7EDO4DVdJb5xW1SDJXsPUhOLOP6wg0kWV+DptuihyQ9b2910jVEnw9z1XR8hBa2Xl8VaYsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/dQ1b5D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/dQ1b5D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2AEAC4CEE2;
	Tue,  4 Feb 2025 18:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738695084;
	bh=deW8O4qvXwa72p0wEVgLCyS0TJzJuu4g79u6uEqpCZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H/dQ1b5D6k1cqO7yRjFifKWB+s8o3O5v1DCzn/PXFlT9AHqyEZh3XlAbnARHDs416
	 ysQf5KnJwU9MgImnsydruqg8kO4rsuqmi/CL6OZD9+sB/Y0+G1IHzGKEEk/aa7La+0
	 UPcH901/1NZ6yGmJYNd4j917ThEfRJLpTDpmkl/G0FuMQshQraDqI/rSVV4/Ks/1Zp
	 wivQORXrfj/QKUOkuYewQElpKdom1rC6r6PNKKJ4WfaiGxtlAAhLYOhUEKXdtqEzq1
	 77BGqGS5icl/vaBiCGDA4zQVp2pKYfH+zvF4VsHRwulEqKPI2LSKWQgmKwDEbuYP8G
	 Jlpz3Uap7rGBQ==
Date: Tue, 4 Feb 2025 10:51:21 -0800
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
Message-ID: <20250204185121.jt5ylxsouqi5dyie@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <77c0d1ec143bf2a53d66c4ecb190e7e0a576fbfd.1737511963.git.jpoimboe@kernel.org>
 <b35ca3a3-8de5-4d32-8d30-d4e562f6b0de@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b35ca3a3-8de5-4d32-8d30-d4e562f6b0de@linux.ibm.com>

On Thu, Jan 30, 2025 at 04:47:00PM +0100, Jens Remus wrote:
> On 22.01.2025 03:31, Josh Poimboeuf wrote:
> > +struct sframe_fre {
> > +	unsigned int	size;
> > +	s32		ip_off;
> 
> The IP offset (from function start) in the SFrame V2 FDE is unsigned:
> 
> u32 ip_off;

Indeed.

> > +#define __UNSAFE_GET_USER_INC(to, from, type, label)			\
> > +({									\
> > +	type __to;							\
> > +	unsafe_get_user(__to, (type __user *)from, label);		\
> > +	from += sizeof(__to);						\
> > +	to = (typeof(to))__to;							\
> > +})
> > +
> > +#define UNSAFE_GET_USER_INC(to, from, size, label)			\
> > +({									\
> > +	switch (size) {							\
> > +	case 1:								\
> > +		__UNSAFE_GET_USER_INC(to, from, u8, label);		\
> > +		break;							\
> > +	case 2:								\
> > +		__UNSAFE_GET_USER_INC(to, from, u16, label);		\
> > +		break;							\
> > +	case 4:								\
> > +		__UNSAFE_GET_USER_INC(to, from, u32, label);		\
> > +		break;							\
> > +	default:							\
> > +		return -EFAULT;						\
> > +	}								\
> > +})
> 
> This does not work for the signed SFrame fields, such as the FRE CFA,
> RA, and FP offsets, as it does not perform the required sign extension.
> One option would be to rename to UNSAFE_GET_USER_UNSIGNED_INC() and
> re-introduce UNSAFE_GET_USER_SIGNED_INC() using s8, s16, and s32.

See the following line in __UNSAFE_GET_USER_INC():

	to = (typeof(to))__to;

Does that not do the sign extension?

-- 
Josh
