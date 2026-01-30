Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B558221D3F5;
	Fri, 30 Jan 2026 08:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769760740; cv=none; b=nbC6TqLiYEr4A4/uhxYfxPOsovLnnQbwOGCZDD9qcuF4LwmTNpGFjORY9+NoH9jwN1zdjjYET9QI+c00J5AFuaZ70qr5ibQKFQiXRWVeinlSxW5C0/MIdAxSW2UlTrJl4NhVi39+XeqxOOQ4hSAUej+RkkTmgfNpgbaHOIaIBFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769760740; c=relaxed/simple;
	bh=6vqIOwWrUBEj6pBxqSLCirJcXubNPGa/Mhh13BUjoh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MxamTnZrby4L7JNSOKY7fQI4gSuucZmM8VRuiaYD7jyN31WQ6ZV/FiNn2W06FRLzI0OVnNwELTiCO2GbyjIGOM2N4i03cCcZrL0zTGLxSEUMHGrKkzTpVEi68+awZuR9yIAVmNg9HR2eYY8bZ3QHTrUJUoueBDw+steHIy8YIxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpaP1u1i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpaP1u1i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C4AC4CEF7;
	Fri, 30 Jan 2026 08:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769760740;
	bh=6vqIOwWrUBEj6pBxqSLCirJcXubNPGa/Mhh13BUjoh0=;
	h=From:To:Cc:Subject:Date:From;
	b=FpaP1u1iBMa5la1E2g168EylLEaCZ3umFyZPbgWiJR55bPycAhjWTYBlzzd4dNdXx
	 axnPyoSvMXhFZfqVFOUhvYKyXBG7gXSOJvV4q8AlgcTN41SUF9OZ3gWlj2puGdlsT6
	 cgWuvMGINh5CwB0a9NPiAe8BUiST+Hja1TEBSAnn9fDZ6QRFiDiI1ArfN4X0QGJ2km
	 3dewlTOin2z8a2k6NbUPxUtwUullgFdOkioj0wrm5ItokQeg7iVUkQNL9EdV1xryr0
	 tJZxILM2gof0QdWC7w9wI6O5Bh1wNKoIAuMSo9mFgq3xGQamwo/bh0EgsQO2OMojtK
	 6RmXuQJbcnZHw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf-next 0/2] bpf: tail calls in sleepable programs
Date: Fri, 30 Jan 2026 09:12:06 +0100
Message-ID: <20260130081208.1130204-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
this patchset allows sleepable programs to use tail calls.

At the moment we need to have separate sleepable uprobe program
to retrieve user space data and pass it to complex program with
tail calls. It'd be great if the program with tail calls could
be sleepable and do the data retrieval directly.

thanks,
jirka


---
Jiri Olsa (2):
      bpf: Allow sleepable programs to use tail calls
      selftests/bpf: Add test for sleepable program tailcalls

 include/linux/bpf.h                                    |  1 +
 kernel/bpf/core.c                                      |  4 +++-
 kernel/bpf/verifier.c                                  |  1 +
 tools/testing/selftests/bpf/prog_tests/tailcalls.c     | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/tailcall_sleepable.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 123 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_sleepable.c
