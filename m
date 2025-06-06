Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1D27FD;
	Fri,  6 Jun 2025 20:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749241058; cv=none; b=XQdBklY0Q8Iqpu30uWbC2uYlHeYO/w94IHz44WyE+B4k/L98DCsglFEQP3Z4iQSUY3ryKz+CsVJNBP2tuzRduQi+1GqSYWeLcvMXqnH6b7TqoH9UYhKDYuh+fF/3eJk+9w/wT+IK/1ejP5WnF6vnprX8oN2g+0H1Ie5H3Sf0G/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749241058; c=relaxed/simple;
	bh=xo8VKm0/2nL/L70Nvv0cwJxphDlhCnT+pw1XJfzarG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyets9b9Zyhz7uLV3nkh/5PRms/KV/StdKzvRNCbi0xtWrYBrOt6CqUNVdgIGHmvJzjE1WFVEQfxQ+HDaXqlhk4vx5VI30zWmco+qtBNUL7J4gppShJvTuBfRqUHFBuHRwq+0LgkpDUDiuhsFdHCbYV3S8UYJm2MWCJuTmdI1i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtD3Hipr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtD3Hipr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAEDC4CEEB;
	Fri,  6 Jun 2025 20:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749241058;
	bh=xo8VKm0/2nL/L70Nvv0cwJxphDlhCnT+pw1XJfzarG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VtD3Hiprq5zyy8Swg6g7TrobqWadI0b4cz8odsJy85UXU2VI1zgBM8nAWGPgvfnyn
	 skJmqELd9u7fwcinw0xLEzdY6VrMbaDhbFfCvx70x5aYJOReFQtuMrle084jFBjXOX
	 qQfzZBByGsfkjCchGRwp6ypUQjLwxvvsGV+PpmvDeaD6uMWAjudkxOM79PPv6jvhEj
	 z+R5qDJc/bFEUPNYcYr2TO2sT8KJdTaJ455KjQEyCPBPH4a0wA3j86GKuOrnuF2PCX
	 KmBUFmFG140RMan874RKdYg7IWMCShutjm6v1GsVZ8/v3OwftRm7AenBAUNkRsRZ9i
	 CG58aku5AqCMQ==
Date: Fri, 6 Jun 2025 17:17:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Yuzhuo Jing <yuzhuo@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
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
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v1 2/4] perf tools: Add sha1 utils
Message-ID: <aENM39y1XBf6ajKi@x1>
References: <20250521225307.743726-1-yuzhuo@google.com>
 <20250521225307.743726-3-yuzhuo@google.com>
 <aC9lXhPFcs5fkHWH@x1>
 <CADQikVDs3msXqZ6tyoXR0WeN4D_9snxWyk2kXeDw5iAs+BHFuw@mail.gmail.com>
 <CAP-5=fV11L=5cBaYcd0ftVyk8=Tm4+NWCoTG+MBnAwjEogS5iA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV11L=5cBaYcd0ftVyk8=Tm4+NWCoTG+MBnAwjEogS5iA@mail.gmail.com>

On Fri, Jun 06, 2025 at 11:27:28AM -0700, Ian Rogers wrote:
> On Wed, Jun 4, 2025 at 11:17 AM Yuzhuo Jing <yuzhuo@google.com> wrote:
> > Thanks for testing the patches!

You're welcome!

> > > In file included from util/sha1_generic.c:18:
> > > util/sha1_base.h: In function ‘sha1_base_do_finalize’:
> > > util/sha1_base.h:77:21: error: comparison of integer expressions of different signedness: ‘unsigned int’ and ‘int’ [-Werror=sign-compare]
> > >    77 |         if (partial > bit_offset) {
> > >       |                     ^
> > > cc1: all warnings being treated as errors
> >
> > Oh, I didn't see that on my GCC 14.2.  A quick fix would work:
> >
> > --- /dev/fd/63  2025-06-04 09:54:42.344516115 -0700
> > +++ tools/perf/util/sha1_base.h 2025-06-03 15:43:39.194036707 -0700
> > @@ -71,7 +69,7 @@
> >  static inline int sha1_base_do_finalize(struct sha1_state *sctx,
> >                                         sha1_block_fn *block_fn)
> >  {
> > -       const int bit_offset = SHA1_BLOCK_SIZE - sizeof(__be64);
> > +       const unsigned int bit_offset = SHA1_BLOCK_SIZE - sizeof(__be64);
> >         __be64 *bits = (__be64 *)(sctx->buffer + bit_offset);
> >         unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
> >
> >
> > To test it, I added -Werror=sign-compare to my local Makefile.config to
> > force the error.
> >
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index d19d1f132726..9909611be301 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -225,9 +225,9 @@ endif
> >
> >  # Treat warnings as errors unless directed not to
> >  ifneq ($(WERROR),0)
> > -  CORE_CFLAGS += -Werror
> > -  CXXFLAGS += -Werror
> > -  HOSTCFLAGS += -Werror
> > +  CORE_CFLAGS += -Werror=sign-compare -Werror
> > +  CXXFLAGS += -Werror=sign-compare -Werror
> > +  HOSTCFLAGS += -Werror=sign-compare -Werror
> >  endif

> >  ifndef DEBUG

> > While testing with "make -C tools/perf -f tests/make make_debug", I saw
> > similar compile errors in libjvmti.c:

> > jvmti/libjvmti.c: In function ‘copy_class_filename’:
> > jvmti/libjvmti.c:148:39: error: comparison of integer expressions of
> > different signedness: ‘int’ and ‘long unsigned int’
> > [-Werror=sign-compare]
> >   148 |                         for (i = 0; i < (size_t)(p - class_sign); i++)
> >       |                                       ^
> > jvmti/libjvmti.c:155:31: error: comparison of integer expressions of
> > different signedness: ‘int’ and ‘size_t’ {aka ‘long unsigned int’}
> > [-Werror=sign-compare]
> >   155 |                 for (j = 0; i < (max_length - 1) && file_name
> > && j < strlen(file_name); j++, i++)
> >       |                               ^
> > jvmti/libjvmti.c:155:68: error: comparison of integer expressions of
> > different signedness: ‘int’ and ‘size_t’ {aka ‘long unsigned int’}
> > [-Werror=sign-compare]
> >   155 |                 for (j = 0; i < (max_length - 1) && file_name
> > && j < strlen(file_name); j++, i++)
> >       |                                                                    ^
> >
> > I've just sent a separate patch to the mailing list:
> > https://lore.kernel.org/lkml/20250604173632.2362759-1-yuzhuo@google.com/T/

> Thanks Yuzhuo! I guess this happened because jvmti.h is missing in the
> test container. It seems to make sense to add -Wsign-compare to the
> standard CFLAGS to lower the chance of breaking this container again.

> > > Humm that part is the same as in the kernel...
> > >
> > > ⬢ [acme@toolbx perf-tools-next]$ line=$(ctags -x --c-kinds=f include/crypto/sha1_base.h | awk '$1 == "sha1_base_do_finalize" {print $3}')
> > > ⬢ [acme@toolbx perf-tools-next]$ sed -n $line,\$p include/crypto/sha1_base.h | awk '{print} /\{/ {c++} /\}/ {c--; if (c==0) exit}' > /tmp/original
> > > ⬢ [acme@toolbx perf-tools-next]$ line=$(ctags -x --c-kinds=f tools/perf/util/sha1_base.h | awk '$1 == "sha1_base_do_finalize" {print $3}')
> > > ⬢ [acme@toolbx perf-tools-next]$ sed -n $line,\$p include/crypto/sha1_base.h | awk '{print} /\{/ {c++} /\}/ {c--; if (c==0) exit}' > /tmp/copy
> > > ⬢ [acme@toolbx perf-tools-next]$ diff -u /tmp/original /tmp/copy
> > > --- /tmp/original       2025-05-22 14:48:31.338406860 -0300
> > > +++ /tmp/copy   2025-05-22 14:48:58.401603439 -0300
> > > @@ -1,3 +1,7 @@
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >  static inline int sha1_base_do_finalize(struct shash_desc *desc,
> > >                                         sha1_block_fn *block_fn)
> > >  {
> > > @@ -13,10 +17,3 @@
> > >
> > >                 block_fn(sctx, sctx->buffer, 1);
> > >         }
> > > -
> > > -       memset(sctx->buffer + partial, 0x0, bit_offset - partial);
> > > -       *bits = cpu_to_be64(sctx->count << 3);
> > > -       block_fn(sctx, sctx->buffer, 1);
> > > -
> > > -       return 0;
> > > -}
> > > ⬢ [acme@toolbx perf-tools-next]$
> >
> > There were some other fixes that I made only to the perf tree version,
> > while maintaining verbatim for other parts.  Here's a script that
> > retains and compares only the copied parts.
> >
> >   # Ignore everything after sha1_transform
> >   diff -u -B -I "^#include " <(sed -n
> > '/EXPORT_SYMBOL(sha1_transform)/q;p' lib/crypto/sha1.c)
> > tools/perf/util/sha1.c
> >   diff -u -B -I "^#include " -I "sha1_zero_message_hash" -I "^struct
> > sha1_state;$" -I "^void sha1_init(__u32 \*buf);$" \
> >       <(sed 's/shash_desc/sha1_state/g;' include/crypto/sha1.h)
> > tools/perf/util/sha1.h
> >   diff -u -B -I "^EXPORT_SYMBOL" -I "^#include " \
> >       <(sed 's/shash_desc \*desc/sha1_state *sctx/g;
> > /shash_desc_ctx(desc)/d' include/crypto/sha1_base.h)
> > tools/perf/util/sha1_base.h
> >   # Ignore everything after crypto_sha1_finup
> >   diff -u -B -I "^EXPORT_SYMBOL" -I "^#include " \
> >       <(sed -n -e '/const u8
> > sha1_zero_message_hash/,/EXPORT_SYMBOL_GPL(sha1_zero_message_hash)/d'
> > \
> >                -e 's/shash_desc/sha1_state/g;
> > /EXPORT_SYMBOL(crypto_sha1_finup)/q;p' crypto/sha1_generic.c) \
> >       tools/perf/util/sha1_generic.c
> >
> > And the changes are as below (including the quick fix above), with one
> > changing the sign and integer type and another fixing type mismatch from
> > const u8 * to const char *.
> >
> > Should we send another patch to the kernel tree version to fix the sign
> > error, or we add rules to allow perf tree only changes?
> 
> I believe there will need to be a set of patches for the kernel sha1
> code (fixing -Wsign-compare, any other typing issues) and a set of
> patches for perf with the check-headers.sh updated as your scripts
> check above.

Right, we try to reuse bits from the kernel as there are more people
working there and its a more critical piece of software than tooling
like perf, so when we notice something in the copies we carry, we better
fix it first in the origin.

> The perf patches shouldn't assume kernel patches have
> landed. The perf check-headers.sh produces a warning but doesn't stop
> the perf build. When the kernel changes land we can update the perf
> check-headers.sh expectations.

Right,

Thanks,

- Arnaldo
 
> Thanks,
> Ian
> 
> > --- /dev/fd/63  2025-06-04 09:54:42.344516115 -0700
> > +++ tools/perf/util/sha1_base.h 2025-06-03 15:43:39.194036707 -0700
> > @@ -71,7 +69,7 @@
> >  static inline int sha1_base_do_finalize(struct sha1_state *sctx,
> >                                         sha1_block_fn *block_fn)
> >  {
> > -       const int bit_offset = SHA1_BLOCK_SIZE - sizeof(__be64);
> > +       const unsigned int bit_offset = SHA1_BLOCK_SIZE - sizeof(__be64);
> >         __be64 *bits = (__be64 *)(sctx->buffer + bit_offset);
> >         unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
> >
> > @@ -95,7 +93,7 @@
> >         __be32 *digest = (__be32 *)out;
> >         int i;
> >
> > -       for (i = 0; i < SHA1_DIGEST_SIZE / sizeof(__be32); i++)
> > +       for (i = 0; i < SHA1_DIGEST_SIZE / (int)sizeof(__be32); i++)
> >                 put_unaligned_be32(sctx->state[i], digest++);
> >
> >         memzero_explicit(sctx, sizeof(*sctx));
> > --- /dev/fd/63  2025-06-04 09:54:42.344516115 -0700
> > +++ tools/perf/util/sha1_generic.c      2025-05-16 10:52:59.219531034 -0700
> > @@ -27,7 +23,7 @@
> >         u32 temp[SHA1_WORKSPACE_WORDS];
> >
> >         while (blocks--) {
> > -               sha1_transform(sst->state, src, temp);
> > +               sha1_transform(sst->state, (const char *)src, temp);
> >                 src += SHA1_BLOCK_SIZE;
> >         }
> >         memzero_explicit(temp, sizeof(temp));
> >
> > Thanks!
> >
> > Best regards,
> > Yuzhuo
