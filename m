Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA06C1C9EBB;
	Thu, 22 Aug 2024 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339404; cv=none; b=eK6YcmiWUT/15hefr2vAaDuLBVqRO96fk0QeXZJruXP4hjBIuF9zoLuei+707NosV2Mnl4zcQJL/RgpfmBNPaJXAfLWcaJIuhuhbnUuYBl0wg+jaiG3iFlQayloApdfAklJisKPeDkhq0/GaG99hfSLtszb8hX6uuP+Dt7p2uXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339404; c=relaxed/simple;
	bh=4mq66x7V1l4K3klSyWVW6E/KR/YVy3Enk8W/rOn2KOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLYGzKYlspzKL9O64kcj/PwzTsemdqtEa7SaTNFuodW1QTwho1lIo/Y8N88mOwCTRZ1N2Ub3GFsQ0NWz8fxRmgjttov1l2xWUobORzIzBegm+XEsNkU9OZWAcBgmWbQhwZoRlXZNrpVeyPNlwvhyFPjzw/7LK/ftYdQnuqPHZhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KptFoEAJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KptFoEAJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C8EC32782;
	Thu, 22 Aug 2024 15:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724339403;
	bh=4mq66x7V1l4K3klSyWVW6E/KR/YVy3Enk8W/rOn2KOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KptFoEAJ9wo/kXdI+utem3eoTuJ9VS0iEfcEljRWz8SBPhQuF8wfe6g1xAcgK42F7
	 /b4D6TyoKo57Au9GH46EHOvjqJTb8XVas3dct2SSnfKKEoi0kiMFWxIzPlZtv49H+m
	 OyOVTtzcRm4mrlASdl7yuk3WKw9wM837khvG1KIpnwkscmSYh1ysZ5rjRoCZ8oNmCM
	 d47vQmDrGHUXToGc0H0rHEJV3X9JskNuVb/meX9cMN3PBJg9VxtvhwlQuwRzK10ZfV
	 KUgObxzbIsl4UJfC/fPZdCh93ymM3d3wizEEknxcL1iL/4nTehCtiGkwlwP/HPQmV+
	 fIMZ+Fm4mNqug==
Date: Thu, 22 Aug 2024 12:09:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [Linux-6.11-rc4] perf BROKEN with LLVM/Clang 19.1.0-rc3
Message-ID: <ZsdUxxBrpbuYxtXN@x1>
References: <CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz2haFneX0C5pUMUUhG-UVKQ@mail.gmail.com>
 <ZsdKhLaPy-uzKsuH@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZsdKhLaPy-uzKsuH@x1>

On Thu, Aug 22, 2024 at 11:26:16AM -0300, Arnaldo Carvalho de Melo wrote:
> So the cast is ok, I think we should disable that
> -Wcast-function-type-mismatch for util/python.o when building with
> clang.
 
> Lemme try to cook a patch for you to test...

Can you try the patch below? Notice that there was already a patch
disabling that for !clang (gcc) for a similar reason:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b7a313d84e853049062011d78cb04b6decd12f5c

------------------------------------------------------------------------------------------
perf tools: Fix python extension build for gcc 8
The gcc 8 compiler won't compile the python extension code with the
following errors (one example):

  python.c:830:15: error: cast between incompatible  function types from              \
  ‘PyObject * (*)(struct pyrf_evsel *, PyObject *, PyObject *)’                       \
  uct _object * (*)(struct pyrf_evsel *, struct _object *, struct _object *)’} to     \
  ‘PyObject * (*)(PyObject *, PyObject *)’ {aka ‘struct _object * (*)(struct _objeuct \
  _object *)’} [-Werror=cast-function-type]
     .ml_meth  = (PyCFunction)pyrf_evsel__open,

The problem with the PyMethodDef::ml_meth callback is that its type is
determined based on the PyMethodDef::ml_flags value, which we set as
METH_VARARGS | METH_KEYWORDS.
<SNIP>
------------------------------------------------------------------------------------------

Can you please check with both clang versions? I just checked with clang
18 as available in in Fedora 40 and it failed in the first, naïve patch,
that simply adds that -Wno- variant:

  GEN     /tmp/build/perf-tools-next/python/perf.cpython-312-x86_64-linux-gnu.so
error: unknown warning option '-Wno-cast-function-type-mismatch'; did you mean '-Wno-cast-function-type-strict'? [-Werror,-Wunknown-warning-option]
error: command '/usr/bin/clang' failed with exit code 1
cp: cannot stat '/tmp/build/perf-tools-next/python_ext_build/lib/perf*.so': No such file or directory

we need to check if clang has that option, we have infra for that, the
patch below works, please try it.

If it works with clang 19 I'll add two patches, one enhancing
clang_has_option and the other using it for this warning only present in
clang 19.

- Arnaldo

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 142e9d447ce721e3..649550e9b7aa8c8f 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -17,7 +17,7 @@ src_feature_tests  = getenv('srctree') + '/tools/build/feature'
 
 def clang_has_option(option):
     cc_output = Popen([cc, cc_options + option, path.join(src_feature_tests, "test-hello.c") ], stderr=PIPE).stderr.readlines()
-    return [o for o in cc_output if ((b"unknown argument" in o) or (b"is not supported" in o))] == [ ]
+    return [o for o in cc_output if ((b"unknown argument" in o) or (b"is not supported" in o) or (b"unknown warning option" in o))] == [ ]
 
 if cc_is_clang:
     from sysconfig import get_config_vars
@@ -63,6 +63,8 @@ cflags = getenv('CFLAGS', '').split()
 cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls' ]
 if cc_is_clang:
     cflags += ["-Wno-unused-command-line-argument" ]
+    if clang_has_option("-Wno-cast-function-type-mismatch"):
+        cflags += ["-Wno-cast-function-type-mismatch" ]
 else:
     cflags += ['-Wno-cast-function-type' ]
 
