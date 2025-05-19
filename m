Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F24142E83;
	Mon, 19 May 2025 21:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747690897; cv=none; b=C2akho77tcDt7OSUQIA9BP4x0Eo4Ts7TM/hQ2zcYsvEXeZHwSomeQnCCyp3DLbeaVj+18nGMj1FJEaqYmSm94jzJz7Ja3uMJ3LSRU1ZB1Xf+LupHvjRvlbQ2V2AWMGRHvW/0AXWTk8dtaMg6SAQtZ4uf2/RGnuOgQFdgd1fXKac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747690897; c=relaxed/simple;
	bh=LLeR1oMBT5ro5QhhHvzjzuKsHgpJLFACybDlcYjBios=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jn9iT23HafG93fM7UQXf5WldbZhDbkg9cIQO8X499rwVaqty8E8z184ZUDERijOBbO+sGFRJZ6X39OuoSAGOujt0577Eu+jNXFdu9ZDfO9WzGAaxmp8UDUjxnsgMuOytl8MvFyh8NhzpuQw8VBO5TJe1oLIsAZoJpl4a3488eo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4lUxS4L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4lUxS4L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6DCC4CEE4;
	Mon, 19 May 2025 21:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747690897;
	bh=LLeR1oMBT5ro5QhhHvzjzuKsHgpJLFACybDlcYjBios=;
	h=From:To:Cc:Subject:Date:From;
	b=X4lUxS4L5eYKXfgC5xwsQptthR27YMnDxp4Z0WIg8CVPQqnBj27LhOWlAKMxokAn0
	 AqeOGQ4moEvEB5yEn1sm5VKane5Kqvv7e97v/zzWg6rzmO6vUxo6kswhKomfvXNEeH
	 +xQGQr/mQ9m/eZlH3wAhJd+cIM/AL4SvgPZX9GDlJP4yI7sRaCLfS6J6sMqan5yabv
	 KycQyfEMFSmFfSAklK/1Gn3qgJfdQWEF4/DWOLU+fMxUHYAR8DjfA+IwENXgCP8DLZ
	 cROuhVD11Daif0eOWpwHnLpzbOvXuhWgA8wJT0lpRiHpNr5eFnwFhZqHmwrLKncoNl
	 U4cAMLSMQAHaA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	I Hsin Cheng <richard120310@gmail.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Peng Jiang <jiang.peng9@zte.com.cn>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Yury Norov <yury.norov@gmail.com>
Subject: [PATCH FYI 0/7] Updating some kernel headers with the kernel sources
Date: Mon, 19 May 2025 18:41:19 -0300
Message-ID: <20250519214126.1652491-1-acme@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Just FYI,

	Updating some kernel headers with the kernel sources.

- Arnaldo

Arnaldo Carvalho de Melo (7):
  tools include UAPI: Sync linux/vhost.h with the kernel sources
  tools arch x86: Sync the msr-index.h copy with the kernel sources
  tools headers x86 cpufeatures: Sync with the kernel sources to pick
    ZEN6 and Indirect Target Selection (ITS) bits
  tools headers: Sync the linux/unaligned.h copy with the kernel sources
  tools headers: Synchronize uapi/linux/bits.h with the kernel sources
  tools headers compiler: Pick the const_true() define from the kernel
    sources
  tools headers: Synchronize linux/bits.h with the kernel sources

 tools/arch/x86/include/asm/cpufeatures.h      |  5 ++++-
 tools/arch/x86/include/asm/msr-index.h        |  8 +++++++
 tools/include/linux/bits.h                    |  5 ++---
 tools/include/linux/compiler.h                | 22 +++++++++++++++++++
 tools/include/uapi/linux/bits.h               |  8 ++-----
 tools/include/vdso/unaligned.h                | 12 +++++-----
 .../trace/beauty/include/uapi/linux/vhost.h   |  4 ++--
 7 files changed, 46 insertions(+), 18 deletions(-)

-- 
2.49.0

