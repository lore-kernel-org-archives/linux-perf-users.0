Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A953AE703;
	Thu,  4 Jun 2026 20:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604811; cv=none; b=C5YWrVCn0l24U9+mW8ZFzkGbmtTi0u6CtvtTM8hVD6f3OQ5fLLJtgjG9de7IRG1lYuJgcc+MIvRXWKbdhgFX8Cz5r1L5UslhNGDcn7FsQumWZId4VMuCWJ/rksPiBj0zpO7SXcj9tTvVYogZjKsg511q9K2ervlZwZsOxTobtIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604811; c=relaxed/simple;
	bh=1iX89a2W5w6vtY+Vwb9j8gOABNrgL+E+dwacAOgnZfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2zW2lzAPoc0PKoHTSWviS4OMIn0UDSEZPw3wD5sd7gq6VWYHwlSh+5D4xJdJMy36VN66BznQhsquWY+sThTZIrxew0zKypnipjaP0Y3i5acYZ1bzEgCpKk1dzpLnh+pmoX2NOTmAHYVUEOz+v4Y+GacYqYKWE488to3EVc1Myg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTiO/J4S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTiO/J4S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A931F00893;
	Thu,  4 Jun 2026 20:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780604809;
	bh=PIcTGLBSvW9gItgvviyTOXD5YkfZ2cneV6imV30Lh4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FTiO/J4STi9Cy0d2CxKHOrDTQXWNI4EOfLjJl6ySyGXQjMT/t2wEAZbpAQgVaO9j8
	 yXx17nHU2nxxc4M5GGtyPCvPTKm617Nv0WbwHpb96eqTD54EZ2yPUVRiAZzYOMD4hi
	 yvWggrar+LtyXhNciGHEBZZBnOfOyWIus9t69HqTwOra5kWOluCLyN7bXMEsdQIZ9M
	 0bShHJc4n7I2S/iG2XeG6jRIsFsnmf7LRSSO6XFcdmZGllm9pDdcdB1ZSylCSotqfb
	 CVmKruWpCPnDwhcHTP9muVu645nMOo3Eh6+IBX5h/+8zUp5moe7w62h5++aqkSp8Sz
	 6XaDoefNnW3KQ==
Date: Thu, 4 Jun 2026 17:26:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
	james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org
Subject: Re: [PATCH v9 2/2] perf test: Truncate printed test descriptions
 dynamically to avoid terminal wrapping
Message-ID: <aiHfhrRBrLojzOA8@x1>
References: <20260602174129.3192312-1-irogers@google.com>
 <20260604163627.501078-1-irogers@google.com>
 <20260604163627.501078-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260604163627.501078-3-irogers@google.com>

On Thu, Jun 04, 2026 at 09:36:27AM -0700, Ian Rogers wrote:
> When test descriptions are extremely long (e.g., the truncated perf.data
> graceful handling test is 103 characters long), they wrap across terminal
> boundaries.
> 
> Because the ANSI escape code to delete the line (PERF_COLOR_DELETE_LINE)
> only clears a single terminal line, visual wrapping leaves orphan
> wrapped lines on the screen, which results in the test description being
> printed multiple times.

  CC      /tmp/build/perf-tools-next/util/bpf_lock_contention.o
tests/builtin-test.c: In function ‘print_test_result.isra’:
tests/builtin-test.c:427:40: error: ‘%-*s’ directive output may be truncated writing between 20 and 65507 bytes into a region of size 256 [-Werror=format-truncation=]
  427 |                 snprintf(buf, buf_sz, "%-*s", width, desc);
      |                                        ^~~~
In file included from /usr/include/stdio.h:974,
                 from /home/acme/git/perf-tools-next/tools/include/linux/panic.h:6,
                 from /home/acme/git/perf-tools-next/tools/include/linux/kernel.h:11,
                 from /home/acme/git/perf-tools-next/tools/include/linux/list.h:7,
                 from /home/acme/git/perf-tools-next/tools/perf/util/config.h:6,
                 from tests/builtin-test.c:26:
In function ‘snprintf’,
    inlined from ‘format_test_description’ at tests/builtin-test.c:427:3,
    inlined from ‘print_test_result.isra’ at tests/builtin-test.c:473:3:
/usr/include/bits/stdio2.h:68:10: note: ‘__builtin___snprintf_chk’ output between 21 and 65508 bytes into a destination of size 256
   68 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   69 |                                    __glibc_objsize (__s), __fmt,
      |                                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   70 |                                    __va_arg_pack ());
      |                                    ~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[4]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:95: /tmp/build/perf-tools-next/tests/builtin-test.o] Error 1
make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:158: tests] Error 2
make[2]: *** [Makefile.perf:566: /tmp/build/perf-tools-next/perf-test-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....
  LD      /tmp/build/perf-tools-next/util/perf-util-in.o
  LD      /tmp/build/perf-tools-next/perf-util-in.o
make[1]: *** [Makefile.perf:288: sub-make] Error 2
make: *** [Makefile:122: install-bin] Error 2
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
⬢ [acme@toolbx perf-tools-next]$


I thought you had fixed this one?

The first patch is applied, testing with it now.

- Arnaldo
