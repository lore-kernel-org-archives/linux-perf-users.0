Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F2F15A85A;
	Thu, 22 May 2025 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747933518; cv=none; b=iefhm0Ewy5yNJvUpdeCmYwg8ZuSqerAKTzAXAXHtVkedTPCUII+qENmgUp8Ef18CZDv95PN4C+9QKDmzbTos0zW1o5NmOKq5sH7YPYUAHzZqE0DXFSKmTji7zAu65gnec56Yp4Gs7agtbt4gFVLvso3LLsfq71BRCxSXE/EZqgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747933518; c=relaxed/simple;
	bh=qstri+tqk+O9EZT92fQLIX0+WT6dPohgFDTdac8pzHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOyz2aAFLeE9sCAq/0R53HoAzc3fkC2/aqY3XLfzq2uzUbI6tm8RQtC0P/SuE5Cw7/Vam2TFqF0FgPVVlbfjNQgFs2dQYr+fS4hZoFVP3oNc4NGEVG5D9Hjlx/vyD8ZnrWSRI6yVC+MWfGDXfSc8kkd+bzozy1Y1b2+cSVVNcCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALRA0jxx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALRA0jxx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423A9C4CEE4;
	Thu, 22 May 2025 17:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747933516;
	bh=qstri+tqk+O9EZT92fQLIX0+WT6dPohgFDTdac8pzHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ALRA0jxx9EGCoUH8l4BhGi3eVtI37aH0eWiBQDgFi2Nb6mCU/rx/4/fuHVh3x3tZs
	 ALr0rpeqOs6PJYJBop9xDEKCEco6UOzc7m7WYwnzcqAW7lfS7nMKYD3EMTkaztEkXx
	 XDOA0mxMlgcoZ69S1ozGdEfqZMbtbnn6y8AS4GyVGt49vMwj3BqEpq+SLCQPXpIxnw
	 Bc7NIrBcwic+HT9t9gnR/Cw4bBOsESp3jAH86RVENyI3M4a2j9Ri6Dc2v6DzibKd6Y
	 E47CTC4Z3Kz3MXug/4Rj4kHSd77/Dl8gcII/oyGgRo+gp4wTgs0xIL7yfWD/g1iBNF
	 RfDnAugQ1ttKQ==
Date: Thu, 22 May 2025 14:05:14 -0300
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
Message-ID: <aC9ZSujcZkZ5KvEy@x1>
References: <20250521225307.743726-1-yuzhuo@google.com>
 <20250521225307.743726-4-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521225307.743726-4-yuzhuo@google.com>

On Wed, May 21, 2025 at 03:53:06PM -0700, Yuzhuo Jing wrote:
> genelf is the only file in perf that depends on libcrypto (or openssl)
> which only calculates a Build ID (SHA1, MD5, or URANDOM).  SHA1 was
> expected to be the default option, but MD5 was used by default due to
> previous issues when linking against Java.  This commit switches genelf
> to use in-house SHA1 utils, and also removes MD5 and URANDOM options
> since we have a reliable SHA1 implementation to rely on.  It passes the
> tools/perf/tests/shell/test_java_symbol.sh test.

Cool, I was going to ask if there was some 'perf test' this could be
tested with, there is, good.

- Arnaldo
 
> Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
> ---
>  tools/perf/util/genelf.c | 72 ++++------------------------------------
>  1 file changed, 6 insertions(+), 66 deletions(-)
> 
> diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
> index cdce7f173d00..cfedb29260ef 100644
> --- a/tools/perf/util/genelf.c
> +++ b/tools/perf/util/genelf.c
> @@ -28,24 +28,7 @@
>  #define NT_GNU_BUILD_ID 3
>  #endif
>  
> -#define BUILD_ID_URANDOM /* different uuid for each run */
> -
> -#ifdef HAVE_LIBCRYPTO_SUPPORT
> -
> -#define BUILD_ID_MD5
> -#undef BUILD_ID_SHA	/* does not seem to work well when linked with Java */
> -#undef BUILD_ID_URANDOM /* different uuid for each run */
> -
> -#ifdef BUILD_ID_SHA
> -#include <openssl/sha.h>
> -#endif
> -
> -#ifdef BUILD_ID_MD5
> -#include <openssl/evp.h>
> -#include <openssl/md5.h>
> -#endif
> -#endif
> -
> +#include "sha1_base.h"
>  
>  typedef struct {
>    unsigned int namesz;  /* Size of entry's owner string */
> @@ -92,64 +75,21 @@ static Elf_Sym symtab[]={
>  	}
>  };
>  
> -#ifdef BUILD_ID_URANDOM
> -static void
> -gen_build_id(struct buildid_note *note,
> -	     unsigned long load_addr __maybe_unused,
> -	     const void *code __maybe_unused,
> -	     size_t csize __maybe_unused)
> -{
> -	int fd;
> -	size_t sz = sizeof(note->build_id);
> -	ssize_t sret;
> -
> -	fd = open("/dev/urandom", O_RDONLY);
> -	if (fd == -1)
> -		err(1, "cannot access /dev/urandom for buildid");
> -
> -	sret = read(fd, note->build_id, sz);
> -
> -	close(fd);
> -
> -	if (sret != (ssize_t)sz)
> -		memset(note->build_id, 0, sz);
> -}
> -#endif
> -
> -#ifdef BUILD_ID_SHA
>  static void
>  gen_build_id(struct buildid_note *note,
>  	     unsigned long load_addr __maybe_unused,
>  	     const void *code,
>  	     size_t csize)
>  {
> -	if (sizeof(note->build_id) < SHA_DIGEST_LENGTH)
> -		errx(1, "build_id too small for SHA1");
> -
> -	SHA1(code, csize, (unsigned char *)note->build_id);
> -}
> -#endif
> -
> -#ifdef BUILD_ID_MD5
> -static void
> -gen_build_id(struct buildid_note *note, unsigned long load_addr, const void *code, size_t csize)
> -{
> -	EVP_MD_CTX *mdctx;
> +	struct sha1_state sctx;
>  
> -	if (sizeof(note->build_id) < 16)
> -		errx(1, "build_id too small for MD5");
> +	if (sizeof(note->build_id) < SHA1_DIGEST_SIZE)
> +		errx(1, "build_id too small for SHA1");
>  
> -	mdctx = EVP_MD_CTX_new();
> -	if (!mdctx)
> -		errx(2, "failed to create EVP_MD_CTX");
> +	sha1_base_init(&sctx);
>  
> -	EVP_DigestInit_ex(mdctx, EVP_md5(), NULL);
> -	EVP_DigestUpdate(mdctx, &load_addr, sizeof(load_addr));
> -	EVP_DigestUpdate(mdctx, code, csize);
> -	EVP_DigestFinal_ex(mdctx, (unsigned char *)note->build_id, NULL);
> -	EVP_MD_CTX_free(mdctx);
> +	crypto_sha1_finup(&sctx, code, csize, (unsigned char *)note->build_id);
>  }
> -#endif
>  
>  static int
>  jit_add_eh_frame_info(Elf *e, void* unwinding, uint64_t unwinding_header_size,
> -- 
> 2.49.0.1164.gab81da1b16-goog
