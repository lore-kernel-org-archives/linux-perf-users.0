Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792739508;
	b=ob/iPQXDhx/wK+a2AINcy/gnX0oaPzmeNxvJmu4NdB+TvMt9Kx/W6X7IJv0716VhQyeZ
	 UztRvscC+ueojjhkfnAstFM4DKEak2QSVlIf+Y5uPAxkRXZvtw4Gz/+NzgUdelXW4vpdv
	 6XVLxi3E2jmElTDXU3oDxgzwXRssZVWdoH355MIEf8yOn2wImoIQpkeIL8WYQdZ/D1ytM
	 +DVWbUIKO80SfoVPNCnnUH/QA7s3FrUD3WOEpX0aD6XyZsQnFwdrZJTnyjfRAFapdrjIK
	 3vzvNwGOwoBNb7DGGJrd7ML/WM+zUYNaR+swVqQ4rksvNZd62CDqfhHdzzCUvGSd0FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792739508;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FLXs+WED32vMT1pMmGB7OWM9VzwdusLxIzbghq50dUM=;
	b=mtX8jaZqsh42ddte8YbgICIbGzJ22WCX51Ac3lpeRoSW8WNffYX6IL4Ub1+tbRXA+1r3
	 i7o5DIOlYrWTlWrerkI5y6ngPeLAz3AQfldhAeu/ush4uj1v/XLANitoRdXL0b47/stnl
	 ntpV8FDL+muWktYpFtNPI5YbtkUCHZU9OLE171crZzRWHIG6oNb46Qu56+zUQ2AZXUmwc
	 /w837qUpmJ3l1RDCaFDdNJAYDlYtqoUdwJ6NqRjnuzJufRniA9AWdxVsSWnyRpnzzxPwg
	 DrJuAhTZQQJrvLilQIUM1Wp3bFLoyrAYo0F2un8534j+JQGDNFWcuJ6hFmZAT+igOCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jnSf4Ppd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AA3606A339;
	Fri, 23 Oct 2026 07:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jnSf4Ppd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CAA1F031E0;
	Fri, 23 Oct 2026 07:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792739507;
	bh=FLXs+WED32vMT1pMmGB7OWM9VzwdusLxIzbghq50dUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jnSf4PpdtOu9iwwG+mK290qFaMX7GbmU18EMVo4Pi1Tqup21S/nXrQQmy/0bNntCm
	 PoOlN8DS1yfdYpwMODMSRJGOrHGypL8GydgIrErnEBpafSr+SURrThqMJkozxMAV/S
	 YwB3vDiF4QgXd74n6SuWpTtwKgh17OUowaLu7/2ZOBrv2DX1sKHAYAfH/cM44XXAMW
	 s89KV9P94CSklUt5+skSdhTYxAvb9kspvTgTX8YM3t0wW6Oida0NANqpJGEdeWu5Wr
	 nnDymQriTRy6iJFg2vFNMmwM0PryVPRhOOiNz6RlUAoGd3qzAXvmtmVtbMv4vrBkzh
	 E7yxJUK/Bl8sA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v1 10/11] perf tools: Only enter mount namespace if necessary
Date: Fri, 23 Oct 2026 00:11:40 -0700
Message-ID: <20261023071141.134149-11-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
In-Reply-To: <20261023071141.134149-1-namhyung@kernel.org>
References: <20261023071141.134149-1-namhyung@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dso_binary_type__needs_ns() to distinguish DSO binary types that
reside inside the target process's mount namespace and chroot from
host-side paths.

Gate mount namespace entry in dso__data_file_size() and do_open() using
dso_binary_type__needs_ns().  And remove redundant outer mountns entry
in around dso__data_get_fd().

Assisted-by: LLM
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/capstone.c |  6 ++++--
 tools/perf/util/dso.c      | 12 ++++++++----
 tools/perf/util/dso.h      | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index 95881f15324aa614..9a8646ff026d92a4 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -653,9 +653,11 @@ int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
 	if (args->options->objdump_path)
 		return -1;
 
-	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
+	if (dso_binary_type__needs_ns(dso__binary_type(dso)))
+		nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 	fd = open(filename, O_RDONLY);
-	nsinfo__mountns_exit(&nsc);
+	if (dso_binary_type__needs_ns(dso__binary_type(dso)))
+		nsinfo__mountns_exit(&nsc);
 	if (fd < 0)
 		return -1;
 
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 4331b48505b2b10e..50dd215f81f6737c 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -682,14 +682,15 @@ static int open_dso(struct dso *dso, struct machine *machine)
 {
 	int fd;
 	struct nscookie nsc;
+	bool nsenter = dso_binary_type__needs_ns(dso__binary_type(dso));
 
-	if (dso__binary_type(dso) != DSO_BINARY_TYPE__BUILD_ID_CACHE) {
+	if (nsenter) {
 		mutex_lock(dso__lock(dso));
 		nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 		mutex_unlock(dso__lock(dso));
 	}
 	fd = __open_dso(dso, machine);
-	if (dso__binary_type(dso) != DSO_BINARY_TYPE__BUILD_ID_CACHE)
+	if (nsenter)
 		nsinfo__mountns_exit(&nsc);
 
 	if (fd >= 0) {
@@ -2081,11 +2082,14 @@ static const u8 *__dso__read_symbol(struct dso *dso, const char *symfs_filename,
 	};
 	u8 *code_buf = NULL;
 	int saved_errno;
+	bool nsenter = dso_binary_type__needs_ns(dso__binary_type(dso));
 
-	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
+	if (nsenter)
+		nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 	fd = open(symfs_filename, O_RDONLY | O_CLOEXEC);
 	saved_errno = errno;
-	nsinfo__mountns_exit(&nsc);
+	if (nsenter)
+		nsinfo__mountns_exit(&nsc);
 	if (fd < 0) {
 		errno = saved_errno;
 		return NULL;
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index e53c83c23c578918..c4ff19f575b88a9e 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -141,6 +141,40 @@ enum dso_binary_type {
 	DSO_BINARY_TYPE__NOT_FOUND,
 };
 
+static inline bool dso_binary_type__needs_ns(enum dso_binary_type type)
+{
+	switch (type) {
+	case DSO_BINARY_TYPE__SYSTEM_PATH_DSO:
+	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE:
+	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP:
+	case DSO_BINARY_TYPE__DEBUGLINK:
+	case DSO_BINARY_TYPE__GNU_DEBUGDATA:
+		return true;
+	case DSO_BINARY_TYPE__KALLSYMS:
+	case DSO_BINARY_TYPE__GUEST_KALLSYMS:
+	case DSO_BINARY_TYPE__VMLINUX:
+	case DSO_BINARY_TYPE__GUEST_VMLINUX:
+	case DSO_BINARY_TYPE__JAVA_JIT:
+	case DSO_BINARY_TYPE__BUILD_ID_CACHE:
+	case DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO:
+	case DSO_BINARY_TYPE__FEDORA_DEBUGINFO:
+	case DSO_BINARY_TYPE__UBUNTU_DEBUGINFO:
+	case DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO:
+	case DSO_BINARY_TYPE__BUILDID_DEBUGINFO:
+	case DSO_BINARY_TYPE__GUEST_KMODULE:
+	case DSO_BINARY_TYPE__GUEST_KMODULE_COMP:
+	case DSO_BINARY_TYPE__KCORE:
+	case DSO_BINARY_TYPE__GUEST_KCORE:
+	case DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO:
+	case DSO_BINARY_TYPE__BPF_PROG_INFO:
+	case DSO_BINARY_TYPE__BPF_IMAGE:
+	case DSO_BINARY_TYPE__OOL:
+	case DSO_BINARY_TYPE__NOT_FOUND:
+	default:
+		return false;
+	}
+}
+
 enum dso_space_type {
 	DSO_SPACE__USER = 0,
 	DSO_SPACE__KERNEL,
-- 
2.56.0.257.gf7497c7d27-goog

