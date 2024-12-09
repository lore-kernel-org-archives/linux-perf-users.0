Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DC719AA72;
	Mon,  9 Dec 2024 20:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733777702; cv=none; b=CBRUVAcWxCNHOQhkHe5TItD0ewy/7GPEL6BUXTb9/dN1i5FZBxBGNCM1ANifJDqhb130z+X+FJeeJTuP7EH+iEisbHWJXuZ76jKzXglABFJ8LiQC2C8sJcv7cUtO+8J6FnSUYUKiCmMq1T9lNqryfdv+1M92GW63ePzpRkjivRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733777702; c=relaxed/simple;
	bh=sT3cu6wLiArOXLV8PeYah6jrUg+dwfQAjmoR0c2zxJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQDf01zHZ2Sk1GsytD56ODKGulI3TQsVEkWM7zIXg12m28yKYL7OFyyI5lHM3E4voNCcntt681OiumMzKxBkojkRQJ0/hkRJeDKMgUmHmWxYrRpbimOX3rpTiAydVbFUHibUzROmDeRLPmmukrg9YKccpLjlHFU7MdPMkDmY8Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMcuXnsK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMcuXnsK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB10AC4CED1;
	Mon,  9 Dec 2024 20:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733777701;
	bh=sT3cu6wLiArOXLV8PeYah6jrUg+dwfQAjmoR0c2zxJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TMcuXnsKxYzVzJL9bw4nOpQXtdLJiEv2ophPJKNluWv5bqysU9IzvJt0qzg9PUfKH
	 iJeh3Hkz7OPoFf4fkAmruFF5oycjzsoefR7hRBavPOB/YgWKo398WEQHYL3AFlCHuI
	 /EikBJVxkqO24HMdQMdiaDBVrnFQseBbVpumnx6lL+6jpb67CMTDF6Omf+OXo6daWU
	 hzHT7g5gaAP9T6TZ3jUhmRcrkE1JodPMvvANG99Q60ZQRjmyOJXrWq+ie0TNLqJ3Pi
	 A4l6N9dmWkUQNW9Ajh3IUL7pvUbrNoikorpQi1X66YRZlFOGrLcmUkI342I3Ep9RkF
	 7doXFI0EjZqIQ==
Date: Mon, 9 Dec 2024 12:54:58 -0800
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
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v3 07/19] unwind: Add user space unwinding API
Message-ID: <20241209205458.vzwkh3ubch5sx5c7@jpoimboe>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <f89a9137e983902f22611e5379606062a64b2382.1730150953.git.jpoimboe@kernel.org>
 <978a9ecd-47e9-442b-8daa-aee8f3d93dbb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <978a9ecd-47e9-442b-8daa-aee8f3d93dbb@linux.ibm.com>

On Fri, Dec 06, 2024 at 11:29:21AM +0100, Jens Remus wrote:
> On 28.10.2024 22:47, Josh Poimboeuf wrote:
> > +	if (ra == prev_ip)
> > +		goto the_end;
> 
> This seems too restrictive to me, as it effectively prevents
> unwinding from recursive functions, e.g. Glibc internal merge sort
> msort_with_tmp():
> 
> $ perf record -F 9999 --call-graph fp /usr/bin/objdump -wdWF /usr/bin/objdump
> $ perf script
> ...
> objdump    8314 236064.515562:     100010 task-clock:ppp:
>                  100630a compare_symbols+0x2a (/usr/bin/objdump)
>              3ffb9e58e7c msort_with_tmp.part.0+0x15c (/usr/lib64/libc.so.6)
>              3ffb9e58d76 msort_with_tmp.part.0+0x56 (/usr/lib64/libc.so.6)
> [unwinding unexpectedly stops]
> 
> Would it be an option to only stop unwinding if both the IP and SP do
> not change?
> 
> if (sp == prev_sp && ra == prev_ra)
> 	gote the_end;

Good point, I've already fixed that for the next version (not yet
posted).  I believe the only thing we really need to check here is that
the unwind is heading in the right direction:

if (cfa <= state->sp)
	goto the_end;

-- 
Josh
