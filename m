Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA594908D6;
	Sat, 25 Jul 2026 12:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784982808; cv=none; b=H3J2prj2FylRbEuqQ4lgyBSh5X7TlJyXgIvGZoMIAYSKc2Gb4GvcsqE+PoKjqvHgwiOzvBLeiNi/cb+3mNuXnsAveiqTrashIptW/gnJAezboVytYM3WP7mjtzlj14Ea1DIRvmp4KF+VyYQtQqnSuZ/Di1Xgcw51xnEbxtWPv4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784982808; c=relaxed/simple;
	bh=XHrBqZkSIY0rgsJRjzOva49ZZg0InIAkaRux2zalkhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wd6ErcFch6hRKYV/rMDahIhsb3a1C845OdwcMaz10ZRxIKzDQENPXiXh3Sn3gFXeH1DcTNb1uAQkeQYL+nJ4vF4oSjsmk7dj+Ep4wOsA0CrRPhYRLdENh4/OPHruEE9gPwCxR91NKzWPtm17jqtXhMPW+zMmQXZFEFVXTosG5o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwSXgxo7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwSXgxo7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E601F000E9;
	Sat, 25 Jul 2026 12:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784982807;
	bh=q79u2W0JbHy/Es41dhQllRhNzsOlmEkY8/5QbD/19Hk=;
	h=From:To:Cc:Subject:Date;
	b=LwSXgxo72NFSZLoSGfjeKSX0uY1gGBnWcjBNkJiVdbFT4EbQK81LsHd5bwx071h0u
	 NEv2PaPgysaOyMnDB9Fga+w9CdQ6oP+iYcYS1NXyBSUkuhP0WIkUOq+eHQtGsr5b8b
	 5smjW8EeG1Vkk8LRKq2XqeuYV2npN0wsRfPPSK7HsiKS1xu0jk1k/SFKbSF0S7gUye
	 BD6nahxF0K85yZ1GTQuprshs1t4Kvh1UQeTEXPKoWpLQNNmKFpeTcxVCjNt/sMGfxk
	 mEfX0tT5WXBg+CaBJ407hRT1eGQkvq5glukoHnLZmpuFfYYkAyjXNB2Gs8owOJOzLA
	 teAgqECFKSwrA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v7.2
Date: Sat, 25 Jul 2026 09:33:17 -0300
Message-ID: <20260725123317.29010-1-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

The following changes since commit 248951ddc14de84de3910f9b13f51491a8cd91df:

  Merge tag 'hwmon-for-v7.2-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging (2026-07-21 08:34:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v7.2-1-2026-07-25

for you to fetch changes up to fac520e43a60230b24026f462a2b63e4d170566e:

  tools headers: Sync KVM headers with the kernel sources (2026-07-21 21:00:10 -0300)

----------------------------------------------------------------
perf tools fixes for v7.2.

- Update header copies of kernel headers, including const.h, fs.h,
  perf_event.h, gfp_types.h, kvm.h, cpufeatures.h, rtnetlink.hp,
  msr-index.h, drm.h and socket.h.

- Add some build files related to BPF skels to .gitignore.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (10):
      perf bench bpf: Add missing .gitignore file
      tools headers UAPI: Sync linux/const.h with the kernel sources
      tools headers UAPI: Sync linux/rtnetlink.h with the kernel sources
      tools headers: Sync linux/gfp_types.h with the kernel sources
      tools headers x86 cpufeatures: Sync with the kernel sources
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      tools headers: Sync UAPI drm/drm.h with kernel sources
      perf beauty: Update copy of linux/socket.h with the kernel sources
      tools headers: Sync UAPI linux/fs.h with the kernel sources
      tools headers: Sync KVM headers with the kernel sources

 tools/arch/s390/include/uapi/asm/kvm.h          |  1 +
 tools/arch/x86/include/asm/cpufeatures.h        |  3 +++
 tools/arch/x86/include/asm/msr-index.h          | 11 +++++++++
 tools/arch/x86/include/uapi/asm/kvm.h           | 14 ++++++-----
 tools/arch/x86/include/uapi/asm/svm.h           | 32 ++++++++++++-------------
 tools/include/linux/gfp_types.h                 | 16 ++++++-------
 tools/include/uapi/linux/const.h                | 18 ++++++++++++++
 tools/include/uapi/linux/kvm.h                  | 20 ++++++++++++----
 tools/include/uapi/linux/rtnetlink.h            |  1 +
 tools/perf/bench/bpf_skel/.gitignore            |  4 ++++
 tools/perf/trace/beauty/include/linux/socket.h  |  2 +-
 tools/perf/trace/beauty/include/uapi/drm/drm.h  | 27 +++++++--------------
 tools/perf/trace/beauty/include/uapi/linux/fs.h | 11 ++++++++-
 13 files changed, 104 insertions(+), 56 deletions(-)
 create mode 100644 tools/perf/bench/bpf_skel/.gitignore
