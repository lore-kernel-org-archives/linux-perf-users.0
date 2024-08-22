Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB1F1CBE94;
	Thu, 22 Aug 2024 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724336776; cv=none; b=LCBaM2LDwpJNIzHYAiodSX3f7ZA4lGTou/ILI648H/ZVtN4uyBd5uODQ6i+YUMiJ4tLFqKtpDVqrXALSPfMJ17mJlHQj7BO9i1LnibtXTmnCMMmmRNNP6DGqZz/VPZig4tmTL+Y4vxJvPCW6rpShmlAcDR5K+dntvthEJT1Dclc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724336776; c=relaxed/simple;
	bh=P15XruFNGOkx76SqKUReYXS/QXrAGCqT1Dbomqu/S2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMg4XI4mzmcQZcspvHT8PMwIVzfU6U7BoKqYPxKZnGu5yVt0kvTArnBvX7MPUoGhHhzdcGlkzFcbN7uHcNDFzLLAD1u5lNb12X204JPPAUMl83v/mmikh6ojlhSydfhrVlCNF+NqXjsHW6CopcGlqRf8FOw94iMe83q0sWhAsao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOA+A/cY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOA+A/cY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDF2C32782;
	Thu, 22 Aug 2024 14:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724336775;
	bh=P15XruFNGOkx76SqKUReYXS/QXrAGCqT1Dbomqu/S2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AOA+A/cYIFuGp7dMTr9xh4a1xoBbL4vDGyO4ZaXWeqXKM2uNmjD7CdEG2UW+T2Mh/
	 LJOEIkbKr9FEjxCUKQIwmjljO2k80sI/6n3YAyTeeCVSk51twnolS03pFaH0W6UK4w
	 3JspTdqUZTaec1ooMfbHAtVLMhEcqqL1a1b8p3v8v9U0ZxmjQKkzhKoKWFh6XHkUdW
	 6Z6IzMrcQPlIFIWc6e604Z0Q4sUEk3l9q1W+x1Azsoaao6JgdoWKdRG6cg7OX2rnfp
	 uqYkSqpfYiP6gn3ZG0RYOd+wMAdBtlzGQlkRWTdJWQEPN1kUEje88ChzDoeJKI3YwQ
	 1LYgJ9H0lzNkQ==
Date: Thu, 22 Aug 2024 11:26:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [Linux-6.11-rc4] perf BROKEN with LLVM/Clang 19.1.0-rc3
Message-ID: <ZsdKhLaPy-uzKsuH@x1>
References: <CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz2haFneX0C5pUMUUhG-UVKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz2haFneX0C5pUMUUhG-UVKQ@mail.gmail.com>

On Wed, Aug 21, 2024 at 09:23:36PM +0200, Sedat Dilek wrote:
> Hi,
> 
> yesterday I jumped to Linux v6.11-rc4+.
> 
> Today, I played with perf.
> 
> I use the SLIM LLVM toolchains from kernel.org.
> 
> Link: https://mirrors.edge.kernel.org/pub/tools/llvm/files/
> 
> LLVM-18 is OK.
> 
> LLVM-19 produces ERRORS.
> 
> [ REPRODUCER ]
> 
> ##LLVM_MVER="18"
> LLVM_MVER="19"
> 
> # Debian LLVM
> ##LLVM_TOOLCHAIN_PATH="/usr/lib/llvm-${LLVM_MVER}/bin"
> # Selfmade LLVM
> LLVM_TOOLCHAIN_PATH="/opt/llvm/bin"
> if [ -d ${LLVM_TOOLCHAIN_PATH} ]; then
>    export PATH="${LLVM_TOOLCHAIN_PATH}:${PATH}"
> fi
> 
> PYTHON_VER="3.12"
> MAKE="make"
> MAKE_OPTS="V=1 -j1 HOSTCC=clang-$LLVM_MVER HOSTLD=ld.lld
> HOSTAR=llvm-ar CC=clang-$LLVM_MVER LD=ld.lld AR=llvm-ar
> STRIP=llvm-strip"
> ##MAKE_OPTS="$MAKE_OPTS NO_LIBTRACEEVENT=1"
> ##MAKE_OPTS="$MAKE_OPTS NO_LIBDEBUGINFOD=1"
> 
> echo "LLVM MVER ........ $LLVM_MVER"
> echo "Path settings .... $PATH"
> echo "Python version ... $PYTHON_VER"
> echo "make line ........ $MAKE $MAKE_OPTS"
> 
> LANG=C LC_ALL=C make -C tools/perf clean 2>&1 | tee ../make-log_perf-clean.txt
> 
> LANG=C LC_ALL=C $MAKE $MAKE_OPTS -C tools/perf
> PYTHON=python${PYTHON_VER} install-bin 2>&1 | tee
> ../make-log_perf-install_bin_python${PYTHON_VER}_llvm${LLVM_MVER}.txt
> 
> [ ERRORS ]
> 
>   '/usr/bin/python3.12' util/setup.py \
>  --quiet build_ext; \
> cp python_ext_build/lib/perf*.so python/
> /home/dileks/src/linux/git/tools/perf/util/python.c:816:15: error:
> cast from 'PyObject *(*)(struct pyrf_evsel *, PyObject *, PyObject *)'
> (aka 'struct _object *(*)(str
> uct pyrf_evsel *, struct _object *, struct _object *)') to
> 'PyCFunction' (aka 'struct _object *(*)(struct _object *, struct
> _object *)') converts to incompatible funct
> ion type [-Werror,-Wcast-function-type-mismatch]
>  816 |                 .ml_meth  = (PyCFunction)pyrf_evsel__open,
>      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

/usr/include/python3.12/object.h:/* PyObject_HEAD defines the initial segment of every PyObject. */
/usr/include/python3.12/object.h:#define PyObject_HEAD                   PyObject ob_base;

And:

struct pyrf_evsel {
        PyObject_HEAD

        struct evsel evsel;
};

So the cast is ok, I think we should disable that
-Wcast-function-type-mismatch for util/python.o when building with
clang.

Lemme try to cook a patch for you to test...

- Arnaldo

> /home/dileks/src/linux/git/tools/perf/util/python.c:1050:15: error:
> cast from 'PyObject *(*)(struct pyrf_evlist *, PyObject *, PyObject
> *)' (aka 'struct _object *(*)(s
> truct pyrf_evlist *, struct _object *, struct _object *)') to
> 'PyCFunction' (aka 'struct _object *(*)(struct _object *, struct
> _object *)') converts to incompatible fu
> nction type [-Werror,-Wcast-function-type-mismatch]
> 1050 |                 .ml_meth  = (PyCFunction)pyrf_evlist__mmap,
>      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /home/dileks/src/linux/git/tools/perf/util/python.c:1056:15: error:
> cast from 'PyObject *(*)(struct pyrf_evlist *, PyObject *, PyObject
> *)' (aka 'struct _object *(*)(s
> truct pyrf_evlist *, struct _object *, struct _object *)') to
> 'PyCFunction' (aka 'struct _object *(*)(struct _object *, struct
> _object *)') converts to incompatible fu
> nction type [-Werror,-Wcast-function-type-mismatch]
> 1056 |                 .ml_meth  = (PyCFunction)pyrf_evlist__open,
>      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /home/dileks/src/linux/git/tools/perf/util/python.c:1062:15: error:
> cast from 'PyObject *(*)(struct pyrf_evlist *, PyObject *, PyObject
> *)' (aka 'struct _object *(*)(s
> truct pyrf_evlist *, struct _object *, struct _object *)') to
> 'PyCFunction' (aka 'struct _object *(*)(struct _object *, struct
> _object *)') converts to incompatible fu
> nction type [-Werror,-Wcast-function-type-mismatch]
> 1062 |                 .ml_meth  = (PyCFunction)pyrf_evlist__poll,
>      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /home/dileks/src/linux/git/tools/perf/util/python.c:1068:15: error:
> cast from 'PyObject *(*)(struct pyrf_evlist *, PyObject *, PyObject
> *)' (aka 'struct _object *(*)(s
> truct pyrf_evlist *, struct _object *, struct _object *)') to
> 'PyCFunction' (aka 'struct _object *(*)(struct _object *, struct
> _object *)') converts to incompatible fu
> nction type [-Werror,-Wcast-function-type-mismatch]
> 1068 |                 .ml_meth  = (PyCFunction)pyrf_evlist__get_pollfd,
>      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /home/dileks/src/linux/git/tools/perf/util/python.c:1074:15: error:
> cast from 'PyObject *(*)(struct pyrf_evlist *, PyObject *, PyObject
> *)' (aka 'struct _object *(*)(s
> truct pyrf_evlist *, struct _object *, struct _object *)') to
> 'PyCFunction' (aka 'struct _object *(*)(struct _object *, struct
> _object *)') converts to incompatible fu
> nction type [-Werror,-Wcast-function-type-mismatch]
> 1074 |                 .ml_meth  = (PyCFunction)pyrf_evlist__add,
>      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /home/dileks/src/linux/git/tools/perf/util/python.c:1080:15: error:
> cast from 'PyObject *(*)(struct pyrf_evlist *, PyObject *, PyObject
> *)' (aka 'struct _object *(*)(s
> truct pyrf_evlist *, struct _object *, struct _object *)') to
> 'PyCFunction' (aka 'struct _object *(*)(struct _object *, struct
> _object *)') converts to incompatible fu
> nction type [-Werror,-Wcast-function-type-mismatch]
> 1080 |                 .ml_meth  = (PyCFunction)pyrf_evlist__read_on_cpu,
>      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /home/dileks/src/linux/git/tools/perf/util/python.c:1244:15: error:
> cast from 'PyObject *(*)(struct pyrf_evsel *, PyObject *, PyObject *)'
> (aka 'struct _object *(*)(st
> ruct pyrf_evsel *, struct _object *, struct _object *)') to
> 'PyCFunction' (aka 'struct _object *(*)(struct _object *, struct
> _object *)') converts to incompatible func
> tion type [-Werror,-Wcast-function-type-mismatch]
> 1244 |                 .ml_meth  = (PyCFunction) pyrf__tracepoint,
>      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 8 errors generated.
> error: command '/opt/llvm/bin/clang-19' failed with exit code 1
> cp: cannot stat 'python_ext_build/lib/perf*.so': No such file or directory
> make[2]: *** [Makefile.perf:737:
> python/perf.cpython-312-x86_64-linux-gnu.so] Error 1
> make[1]: *** [Makefile.perf:290: sub-make] Error 2
> make: *** [Makefile:113: install-bin] Error 2
> make: Leaving directory '/home/dileks/src/linux/git/tools/perf'
> 
> INFO: Full build-log is attached.
> 
> Any known issue?
> 
> Thanks,
> 
> Best regards,
> -Sedat-



