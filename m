Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF7D191F62;
	Fri,  7 Feb 2025 21:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738962808; cv=none; b=ZO7YaESEx7THsVNgsUWlycBL93whip/UMEsIFKQLIcvxaw+q9w5r77o37WUaA6XrqozNiFrIYxGchuvTH1h0DOYp7iDIVTN1gT7+MTozazm98AZArrZMZkZBbRj9NvKGksVQ5OJdt0wcC9FWdbxvjN5U8PAZ5rIeECsV1Gnmx1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738962808; c=relaxed/simple;
	bh=i+FPbLfb3FeZGf8iVI9Kn0P0WUY2o6LfvZIp2136khc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlrjKskJB9DWJDOO/d18vfspcynMLOQLW+55PNMDX7m6OBQjPfLYlw+depcbb03CesKY/rewwfpzsAhqOeuoN91tlvHK8zsXoNBxBJBF/0mJLk89KIHtOSiSbHxs0JkYSf0yO8cEU6H0JtF5HcmQwjiNisHu26BleVvEwoJc/ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIHiE1PX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIHiE1PX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CC5C4CED1;
	Fri,  7 Feb 2025 21:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738962807;
	bh=i+FPbLfb3FeZGf8iVI9Kn0P0WUY2o6LfvZIp2136khc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hIHiE1PXvwu/RZaOU381Yxl961zrhQfjJ/FjF7vm1gr9JDA4FgwbhIKgWC97jRl98
	 98LKU7idXQKvb1j2/O3amjKUtC0fNIWQzdVAlXoJkb6AaoiRs4BBtHB/Myz9SWx6GN
	 onG3LwdCvGZejOYKC4BV7CKnRRVw3EfmDAnt82i9AJwDSkko10uCVDsuADqQjX0Zkq
	 rwYsPL9tF6jOHAfHhYFsrlOyvYKN+TEI1p88x9c4H0eopvfKg25xW2JXIF6ryufrD6
	 ix1TTK1G26mSZIMmXhUCWOT+z+/Sqftr0d9SzeC/JjBxURkScVxbDYiG5loXQ9kSJq
	 HZairn7WZzGEg==
Date: Fri, 7 Feb 2025 13:13:24 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Indu Bhagat <indu.bhagat@oracle.com>, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 17/39] unwind_user/sframe: Add support for reading
 .sframe headers
Message-ID: <20250207211324.jwtyy3z5ud2jwegi@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <f27e8463783febfa0dabb0432a3dd6be8ad98412.1737511963.git.jpoimboe@kernel.org>
 <CAEf4BzbQGipBq-Ls1=n49nyNoX941Ka13HgXAXLTzGAo9wckAA@mail.gmail.com>
 <20250124192159.ypvqwoqjvhasamev@jpoimboe>
 <47f1e244-992f-44fe-a0a5-6c271e9c719e@oracle.com>
 <CAEf4BzZaWrscT1HrcUJkz45iMMuyCcA6ivfMffeHpxf=LmmXRg@mail.gmail.com>
 <20250129020249.owmklacvuvss7z7n@jpoimboe>
 <9a726893-4973-40f0-a2b5-63b2036e2e4e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9a726893-4973-40f0-a2b5-63b2036e2e4e@linux.ibm.com>

On Wed, Feb 05, 2025 at 02:56:36PM +0100, Jens Remus wrote:
> On 29.01.2025 03:02, Josh Poimboeuf wrote:
> 
> > Note FDEs aren't even needed here as the unwinder doesn't need to know
> > when a function begins/ends.  The only info needed by the unwinder is
> > just the fre_data struct.  So a simple binary search of fres[] is all
> > that's really needed.
> 
> In SFrame V2 FDEs specify ranges bound by function start address and
> length.  FREs in contrast specify open ranges bounded by start address.
> Their effect ends either with the next FRE becoming into effect or when
> their FDE range ends.
> This concept enables holes in the .text section which do not have any
> valid FDE/FRE information associated.
> 
> Your proposal lacks some sort of mechanism to replicate those holes.
> It could be FDEs with a flag (or no offsets?) that specifies their
> range has no valid information.

In ORC, a hole is simply specified by an ORC entry (aka "FRE") of type
UNDEFINED.

That could be done here as well: the linker would replace a gap with an
"undefined" FRE which could be identified either by setting a bit in the
FRE header, or by using a special fre_data[] entry.  For example,
fre_data index 0 could just be a placeholder for the undefined FRE type.

-- 
Josh
