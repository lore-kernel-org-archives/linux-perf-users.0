Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C125D48C
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Nov 2023 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bz4SkCeb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595FFC433C8;
	Tue, 28 Nov 2023 17:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701193091;
	bh=RNOf8IUGxxmeyuakZPDZPc9mbJAGG9faA4v5329Ernw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bz4SkCebOTVMTP6Qa7rIp0+bVTQpj0o9TlcZB74as2jAGtg3bYSAUF7Xbs9XhxoJf
	 i3H5zpbjrNdQ0Z9wMVcezaM/z7GU0TOr0qLMPnsQHNFvlCAYh21X/M/GwZDZ2cMuNS
	 ywI6hyORJRnNNuxwrqFV/iY/q6YIFxsVh636iQ8iMZiOr/H/fHWb2yBdMuXvHDJOaI
	 bUg+40VS2I1a6IlJhSAD/b2Qa312hcR4XAFBnd6vJV5JxOcGhl68xRcr9OrasJeocY
	 hWqHXmTy+C5hSwokkLdo9b29Af/tfyOqn+D3oAYRsNuJJB+Eilv9ooTrdP7wvKVtgl
	 CDs1Pb8P4o1vg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 0EDFA40094; Tue, 28 Nov 2023 14:38:09 -0300 (-03)
Date: Tue, 28 Nov 2023 14:38:08 -0300
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
Message-ID: <ZWYlgPwGmAEUKIsE@kernel.org>
References: <20231102175735.2272696-1-irogers@google.com>
 <20231102175735.2272696-5-irogers@google.com>
 <ZWURZvDA2L4Mr3HR@kernel.org>
 <ZWYf+Sy6JKd7CYlN@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWYf+Sy6JKd7CYlN@kernel.org>
X-Url: http://acmel.wordpress.com

Em Tue, Nov 28, 2023 at 02:14:33PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Nov 27, 2023 at 07:00:06PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, Nov 02, 2023 at 10:56:46AM -0700, Ian Rogers escreveu:
> > > Zstd streams create dictionaries that can require significant RAM,
> > > especially when there is one per-CPU. Tools like perf record won't use
> > > the streams without the -z option, and so the creation of the streams
> > > is pure overhead. Switch to creating the streams on first use.

> > > Signed-off-by: Ian Rogers <irogers@google.com>

> > Thanks, applied to perf-tools-next.

> Trying to fix this now:
> 
>   6    20.59 alpine:3.18                   : FAIL gcc version 12.2.1 20220924 (Alpine 12.2.1_git20220924-r10)
>     In file included from util/zstd.c:5:
>     /git/perf-6.6.0-rc1/tools/perf/util/compress.h:34:1: error: unknown type name 'ssize_t'; did you mean 'size_t'?

So the problem was really the one above, that got fixed with the patch
below, that is what 'man size_t' documents on my fedora:38 system.

- Arnaldo

diff --git a/tools/perf/util/compress.h b/tools/perf/util/compress.h
index 9eb6eb5bf038ce54..b29109cd36095c4f 100644
--- a/tools/perf/util/compress.h
+++ b/tools/perf/util/compress.h
@@ -3,7 +3,8 @@
 #define PERF_COMPRESS_H
 
 #include <stdbool.h>
-#include <stdlib.h>
+#include <stddef.h>
+#include <sys/types.h>
 #ifdef HAVE_ZSTD_SUPPORT
 #include <zstd.h>
 #endif

>        34 | ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
>           | ^~~~~~~
>           | size_t
>     util/zstd.c:31:9: error: conflicting types for 'zstd_compress_stream_to_records'; have 'ssize_t(struct zstd_data *, void *, size_t,  void *, size_t,  size_t,  size_t (*)(void *, size_t))' {aka 'long int(struct zstd_data *, void *, long unsigned int,  void *, long unsigned int,  long unsigned int,  long unsigned int (*)(void *, long unsigned int))'}
>        31 | ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     /git/perf-6.6.0-rc1/tools/perf/util/compress.h:34:9: note: previous declaration of 'zstd_compress_stream_to_records' with type 'int(struct zstd_data *, void *, size_t,  void *, size_t,  size_t,  size_t (*)(void *, size_t))' {aka 'int(struct zstd_data *, void *, long unsigned int,  void *, long unsigned int,  long unsigned int,  long unsigned int (*)(void *, long unsigned int))'}
>        34 | ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     make[3]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:158: util] Error 2
>       CC      /tmp/build/perf/util/zstd.o
>       CC      /tmp/build/perf/util/cap.o
>       CXX     /tmp/build/perf/util/demangle-cxx.o
>       CC      /tmp/build/perf/util/demangle-ocaml.o
>     In file included from util/zstd.c:5:
>     /git/perf-6.6.0-rc1/tools/perf/util/compress.h:34:1: error: unknown type name 'ssize_t'; did you mean 'size_t'?
>        34 | ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
>           | ^~~~~~~
>           | size_t
>       CC      /tmp/build/perf/util/demangle-java.o
>     util/zstd.c:31:9: error: conflicting types for 'zstd_compress_stream_to_records'; have 'ssize_t(struct zstd_data *, void *, size_t,  void *, size_t,  size_t,  size_t (*)(void *, size_t))' {aka 'long int(struct zstd_data *, void *, long unsigned int,  void *, long unsigned int,  long unsigned int,  long unsigned int (*)(void *, long unsigned int))'}
>        31 | ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     /git/perf-6.6.0-rc1/tools/perf/util/compress.h:34:9: note: previous declaration of 'zstd_compress_stream_to_records' with type 'int(struct zstd_data *, void *, size_t,  void *, size_t,  size_t,  size_t (*)(void *, size_t))' {aka 'int(struct zstd_data *, void *, long unsigned int,  void *, long unsigned int,  long unsigned int,  long unsigned int (*)(void *, long unsigned int))'}
>        34 | ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
>    7    21.14 alpine:edge                   : FAIL gcc version 13.1.1 20230722 (Alpine 13.1.1_git20230722)
>     In file included from util/zstd.c:5:
>     /git/perf-6.6.0-rc1/tools/perf/util/compress.h:34:1: error: unknown type name 'ssize_t'; did you mean 'size_t'?
>        34 | ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
>           | ^~~~~~~
>           | size_t
>     util/zstd.c:31:9: error: conflicting types for 'zstd_compress_stream_to_records'; have 'ssize_t(struct zstd_data *, void *, size_t,  void *, size_t,  size_t,  size_t (*)(void *, size_t))' {aka 'long int(struct zstd_data *, void *, long unsigned int,  void *, long unsigned int,  long unsigned int,  long unsigned int (*)(void *, long unsigned int))'}
>        31 | ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     /git/perf-6.6.0-rc1/tools/perf/util/compress.h:34:9: note: previous declaration of 'zstd_compress_stream_to_records' with type 'int(struct zstd_data *, void *, size_t,  void *, size_t,  size_t,  size_t (*)(void *, size_t))' {aka 'int(struct zstd_data *, void *, long unsigned int,  void *, long unsigned int,  long unsigned int,  long unsigned int (*)(void *, long unsigned int))'}
>        34 | ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     make[3]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:158: util] Error 2
>       CC      /tmp/build/perf/util/cap.o
>       CXX     /tmp/build/perf/util/demangle-cxx.o
>       CC      /tmp/build/perf/util/demangle-ocaml.o
>       CC      /tmp/build/perf/util/demangle-java.o
>     In file included from util/zstd.c:5:
>     /git/perf-6.6.0-rc1/tools/perf/util/compress.h:34:1: error: unknown type name 'ssize_t'; did you mean 'size_t'?
>        34 | ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
>           | ^~~~~~~
>           | size_t
>     util/zstd.c:31:9: error: conflicting types for 'zstd_compress_stream_to_records'; have 'ssize_t(struct zstd_data *, void *, size_t,  void *, size_t,  size_t,  size_t (*)(void *, size_t))' {aka 'long int(struct zstd_data *, void *, long unsigned int,  void *, long unsigned int,  long unsigned int,  long unsigned int (*)(void *, long unsigned int))'}
>        31 | ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     /git/perf-6.6.0-rc1/tools/perf/util/compress.h:34:9: note: previous declaration of 'zstd_compress_stream_to_records' with type 'int(struct zstd_data *, void *, size_t,  void *, size_t,  size_t,  size_t (*)(void *, size_t))' {aka 'int(struct zstd_data *, void *, long unsigned int,  void *, long unsigned int,  long unsigned int,  long unsigned int (*)(void *, long unsigned int))'}
>        34 | ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 

-- 
