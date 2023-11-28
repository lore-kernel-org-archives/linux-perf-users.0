Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424C341C76
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Nov 2023 20:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhKeSxSO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDED7C433C8;
	Tue, 28 Nov 2023 20:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701203368;
	bh=LZUDexNsDfHLTiZ4vVRpRhkkcAv3/p4UDi4s40i48v4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OhKeSxSO/+o1xVPh+tVwuB7lC0aY6qGjLmq8MfFmK6FOP6uqqFw7rQv6QJvQfn8fg
	 Bwt9XF6Ohp8j0E0656s9FJM4udBDzPjufetxZD9cUL+o1M3/30QK48CIcRuxnCqVDG
	 zTI/eu2XZtyWnYFmi9bbXafQIeXNNzKSDEZLRApPl9WZYgJPS2yB4xfE8h3f7+nwVq
	 i3mn1qROrQqIG3yplMopoHS6dxOEy7v59xX39wQSmNi8wBodbgRg1nfxxgQAmoo3Fs
	 zY+G8zm8UbLCFjilY/KzkvYhjG/dY6zSjyHDFfk0gm8N/E9Jd4zQazLFZauCCWrtfd
	 dRISCTybmDIZA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 93DD540094; Tue, 28 Nov 2023 17:29:25 -0300 (-03)
Date: Tue, 28 Nov 2023 17:29:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Colin Ian King <colin.i.king@gmail.com>,
	Dmitrii Dolgov <9erthalion6@gmail.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Ming Wang <wangming01@loongson.cn>,
	James Clark <james.clark@arm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Leo Yan <leo.yan@linaro.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
	German Gomez <german.gomez@arm.com>,
	Changbin Du <changbin.du@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
	Sandipan Das <sandipan.das@amd.com>,
	liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 04/53] perf mmap: Lazily initialize zstd streams
Message-ID: <ZWZNpdAGL58ViyNZ@kernel.org>
References: <20231102175735.2272696-1-irogers@google.com>
 <20231102175735.2272696-5-irogers@google.com>
 <ZWURZvDA2L4Mr3HR@kernel.org>
 <ZWYf+Sy6JKd7CYlN@kernel.org>
 <ZWYlgPwGmAEUKIsE@kernel.org>
 <CAP-5=fVgVY8hhhhgW-aJic6Vez2CJmA8VLx+Az3kKJFB7fz1Pg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVgVY8hhhhgW-aJic6Vez2CJmA8VLx+Az3kKJFB7fz1Pg@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Tue, Nov 28, 2023 at 09:55:22AM -0800, Ian Rogers escreveu:
> On Tue, Nov 28, 2023 at 9:38 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Em Tue, Nov 28, 2023 at 02:14:33PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Trying to fix this now:
> > >
> > >   6    20.59 alpine:3.18                   : FAIL gcc version 12.2.1 20220924 (Alpine 12.2.1_git20220924-r10)
> > >     In file included from util/zstd.c:5:
> > >     /git/perf-6.6.0-rc1/tools/perf/util/compress.h:34:1: error: unknown type name 'ssize_t'; did you mean 'size_t'?

> > So the problem was really the one above, that got fixed with the patch
> > below, that is what 'man size_t' documents on my fedora:38 system.
 
> Thanks, perhaps this is something clang-tidy, clang-format or similar
> could help with in the future. There was event IWYU discussion at LPC:
> https://lpc.events/event/17/contributions/1620/attachments/1228/2520/Linux%20Kernel%20Header%20Optimization.pdf

Yeah, that is interesting, I took a quick look and it looks promising.

I did this manually in various areas of the kernel and in tools/perf
from time to time, to speed up the building process, etc.

- Arnaldo
