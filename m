Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D2C18EFD4;
	Thu, 22 May 2025 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747934593; cv=none; b=gVHU8QtDNLb+cAoh2xQB/hcWh3z5SpAInYGlOCMKnYixEJtmkh2HBJW7qbzL3NsA18dQRNta5QZOw6QcmmWOnsxGg7Ltjyg8lVLbEztVVUQE03e563wYDEi1izCjjTU1a6kGwhw/vo2TvRUgJBMtzjzrl0g02z11wTn3eK5OGww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747934593; c=relaxed/simple;
	bh=JjR+nmRa2hLatx3hmN5ju8mpmK8z/ZMS5B5nSy+f5tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WI2e14lYFz3Uwzia+QUQZb5R0MHZ22OvkLu+Ncd5R5XRrMSzY98OBRU/RfT1pt9AGXdDsOBW57otnDsGwJM/A7IuRRh3Cgt4fy+h7Sn1zxjjX1AL/qtS/eJiWfmixhlQwEQW623iQ79vHnfCCR1Emmd6/CrTcY/vViF8I9iGeMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFNsmb7V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFNsmb7V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF536C4CEEA;
	Thu, 22 May 2025 17:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747934593;
	bh=JjR+nmRa2hLatx3hmN5ju8mpmK8z/ZMS5B5nSy+f5tw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZFNsmb7Vbyp5bUzLnk0JNakRx7rhHMoaaIeKJl+RbTPb2Cm4WEQDMEBXDYvAUYVOW
	 veC7376ZOo65xfdrBMD5Cj7d1pqL+0CRnWgn5zYsqOfl5uWrWltqmuRFiAyNsMq9pE
	 Hh156qkb3SuZ+9nwLzeM5nDwW/mBs6nn6C94wMvOI6qPb2n3+LIU50h2xoRLVoXYzM
	 odxr96rTUOxmhtPVbQimlhaRWVBw3Jv3fyRVvzWwVDo64MzuoL9j08tgzlxpdWQAPz
	 Fw+ZvpruxM3jnscmdsxEONoVsXxmAYZKrQbMjCNlqSeHGyj3PkpWaT9M2lCY3sgn7g
	 Ul1BG1ZxYKzqw==
Date: Thu, 22 May 2025 14:23:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Yuzhuo Jing <yuzhuo@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	James Clark <james.clark@linaro.org>,
	Tomas Glozar <tglozar@redhat.com>, Leo Yan <leo.yan@arm.com>,
	Guilherme Amadio <amadio@gentoo.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v1 3/4] perf genelf: Remove libcrypto dependency and use
 sha1 utils
Message-ID: <aC9dfhZ4B-kfQiwb@x1>
References: <20250521225307.743726-1-yuzhuo@google.com>
 <20250521225307.743726-4-yuzhuo@google.com>
 <aC9ZSujcZkZ5KvEy@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aC9ZSujcZkZ5KvEy@x1>

On Thu, May 22, 2025 at 02:05:17PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, May 21, 2025 at 03:53:06PM -0700, Yuzhuo Jing wrote:
> > genelf is the only file in perf that depends on libcrypto (or openssl)
> > which only calculates a Build ID (SHA1, MD5, or URANDOM).  SHA1 was
> > expected to be the default option, but MD5 was used by default due to
> > previous issues when linking against Java.  This commit switches genelf
> > to use in-house SHA1 utils, and also removes MD5 and URANDOM options
> > since we have a reliable SHA1 implementation to rely on.  It passes the
> > tools/perf/tests/shell/test_java_symbol.sh test.

> Cool, I was going to ask if there was some 'perf test' this could be
> tested with, there is, good.

I applied the series locally and while testing on a new machine I
noticed some issues with the existing test_java_symbol.sh test, namely:

root@number:~# perf test -vvvv "Test java symbol"
105: Test java symbol:
--- start ---
test child forked, pid 85204
skip: no jshell, install JDK
---- end(-2) ----
105: Test java symbol                                                : Skip
root@number:~# 

So I had to re-figure out where that thing was, after I installed
java-latest-openjdk-devel the test passed, so I'll write a follow up
patch that will add a the reason for the skip suggesting that the needed
devel file be installed.

Also using -vvv:

root@number:~# perf test "Test java symbol"
105: Test java symbol                                                : Ok
root@number:~# perf test -vvvvv "Test java symbol"
105: Test java symbol:
--- start ---
test child forked, pid 86083
jshell: jvmti: jitdump in /root/.debug/jit/java-jit-20250522.XXYVwxbq/jit-86090.dump
-> int fib(int x) {
>>      return x > 1 ? fib(x - 2) + fib(x - 1) : 1;
>>     -> -> -> -> -> -> 143
-> [ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.436 MB /tmp/__perf_test.perf.data.zt9Jv (10113 samples) ]
Cleaning up files...
---- end(0) ----
105: Test java symbol                                                : Ok
root@number:~# 
root@number:~# ls -la /root/.debug/jit/java-jit-20250522.XXYVwxbq/jit-86090.dump
-rw-r--r--. 1 root root 13065557 May 22 14:18 /root/.debug/jit/java-jit-20250522.XXYVwxbq/jit-86090.dump
root@number:~#

It creates that jit-86090.dump file but leaves it in the ~/.debug/
directory, polluting it, it should remove it at the test exit.

None are issues introduced by your patch set, so should be fixed as
followup patches that I'll do after processing more outstanding patches
unless someone beats me to it ;-)

I'm keeping your patches in my local repo to give some more time for
reviewing, they will go thru container tests in lots of distros
meanwhile.

Thanks,

- Arnaldo
 
> - Arnaldo
>  
> > Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
> > ---
> >  tools/perf/util/genelf.c | 72 ++++------------------------------------
> >  1 file changed, 6 insertions(+), 66 deletions(-)
> > 
> > diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
> > index cdce7f173d00..cfedb29260ef 100644
> > --- a/tools/perf/util/genelf.c
> > +++ b/tools/perf/util/genelf.c
> > @@ -28,24 +28,7 @@
> >  #define NT_GNU_BUILD_ID 3
> >  #endif
> >  
> > -#define BUILD_ID_URANDOM /* different uuid for each run */
> > -
> > -#ifdef HAVE_LIBCRYPTO_SUPPORT
> > -
> > -#define BUILD_ID_MD5
> > -#undef BUILD_ID_SHA	/* does not seem to work well when linked with Java */
> > -#undef BUILD_ID_URANDOM /* different uuid for each run */
> > -
> > -#ifdef BUILD_ID_SHA
> > -#include <openssl/sha.h>
> > -#endif
> > -
> > -#ifdef BUILD_ID_MD5
> > -#include <openssl/evp.h>
> > -#include <openssl/md5.h>
> > -#endif
> > -#endif
> > -
> > +#include "sha1_base.h"
> >  
> >  typedef struct {
> >    unsigned int namesz;  /* Size of entry's owner string */
> > @@ -92,64 +75,21 @@ static Elf_Sym symtab[]={
> >  	}
> >  };
> >  
> > -#ifdef BUILD_ID_URANDOM
> > -static void
> > -gen_build_id(struct buildid_note *note,
> > -	     unsigned long load_addr __maybe_unused,
> > -	     const void *code __maybe_unused,
> > -	     size_t csize __maybe_unused)
> > -{
> > -	int fd;
> > -	size_t sz = sizeof(note->build_id);
> > -	ssize_t sret;
> > -
> > -	fd = open("/dev/urandom", O_RDONLY);
> > -	if (fd == -1)
> > -		err(1, "cannot access /dev/urandom for buildid");
> > -
> > -	sret = read(fd, note->build_id, sz);
> > -
> > -	close(fd);
> > -
> > -	if (sret != (ssize_t)sz)
> > -		memset(note->build_id, 0, sz);
> > -}
> > -#endif
> > -
> > -#ifdef BUILD_ID_SHA
> >  static void
> >  gen_build_id(struct buildid_note *note,
> >  	     unsigned long load_addr __maybe_unused,
> >  	     const void *code,
> >  	     size_t csize)
> >  {
> > -	if (sizeof(note->build_id) < SHA_DIGEST_LENGTH)
> > -		errx(1, "build_id too small for SHA1");
> > -
> > -	SHA1(code, csize, (unsigned char *)note->build_id);
> > -}
> > -#endif
> > -
> > -#ifdef BUILD_ID_MD5
> > -static void
> > -gen_build_id(struct buildid_note *note, unsigned long load_addr, const void *code, size_t csize)
> > -{
> > -	EVP_MD_CTX *mdctx;
> > +	struct sha1_state sctx;
> >  
> > -	if (sizeof(note->build_id) < 16)
> > -		errx(1, "build_id too small for MD5");
> > +	if (sizeof(note->build_id) < SHA1_DIGEST_SIZE)
> > +		errx(1, "build_id too small for SHA1");
> >  
> > -	mdctx = EVP_MD_CTX_new();
> > -	if (!mdctx)
> > -		errx(2, "failed to create EVP_MD_CTX");
> > +	sha1_base_init(&sctx);
> >  
> > -	EVP_DigestInit_ex(mdctx, EVP_md5(), NULL);
> > -	EVP_DigestUpdate(mdctx, &load_addr, sizeof(load_addr));
> > -	EVP_DigestUpdate(mdctx, code, csize);
> > -	EVP_DigestFinal_ex(mdctx, (unsigned char *)note->build_id, NULL);
> > -	EVP_MD_CTX_free(mdctx);
> > +	crypto_sha1_finup(&sctx, code, csize, (unsigned char *)note->build_id);
> >  }
> > -#endif
> >  
> >  static int
> >  jit_add_eh_frame_info(Elf *e, void* unwinding, uint64_t unwinding_header_size,
> > -- 
> > 2.49.0.1164.gab81da1b16-goog
