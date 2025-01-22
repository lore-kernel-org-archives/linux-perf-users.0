Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8F61B6CE0;
	Wed, 22 Jan 2025 02:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737513123; cv=none; b=ncyFZ2kRBO5lcC8Gxssg3vbprKp0pYZmmdp/k9OwGsWemhvAH/iZ6g7kf3RlsQrma8Ror/TxmAJACOf9bGTeaA+SEgFUdZ1cldRrUWTXXvoN+iB3LR21Ua537D6rh5giK8/gv+XLcCeSrNsX6mCgURiJehg8oc6tGDtpTObya08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737513123; c=relaxed/simple;
	bh=Rb/Fdy6T2RvQ4lc9AaJaiRjGQahqOtSOdksdssQWDWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1lGBEbK4iqCAwdWvzWDmGMTgXidQb8qerflVvrjQhoYi9bFW59k2Vr1dxWP0pOAX8zKgiYIUlukZhsXWCzxTROgC0QxXSer51yWsg7U4EwOuCXkwW4BaX/HDG6Stoy3JVITqtb05CsyPeLu6xCbp5oeplSa3SF1uwbdHaSQFqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BM+YI4AG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BM+YI4AG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE35EC4CEE4;
	Wed, 22 Jan 2025 02:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737513122;
	bh=Rb/Fdy6T2RvQ4lc9AaJaiRjGQahqOtSOdksdssQWDWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BM+YI4AGwvkVjpQMlBvBgOnJsDNeM2cGUoYOee2uR/CUO33NnZohdIUtSA/CacY3l
	 iVOfE4isUyPIKGBmecbXZ2d/Abqfk8xen9wnbsLe0wWU9sM4foOA+TMIuBJ/LjsFyV
	 Mh6klpM7MCfiY7AfJIc7VvcrmD/ElbMQShPCaw0xTvappUagYABXPfT5Juy1nO2y91
	 xRLR+qqxs+TOIwWx8wu75/8/CpWe9wbiUMUtKb7jH/cEdOEkAo+Uq73dDdoDegrQ8/
	 3e1E893BM+jghHeY/GLP+Bf32Q/Lq5oUixUuBpGOgLopDIc0UI9lgNQGIw2CmlE1S6
	 YP8A6XXSJbovw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org,
	Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>,
	linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: [PATCH v4 10/39] x86/uaccess: Add unsafe_copy_from_user() implementation
Date: Tue, 21 Jan 2025 18:31:02 -0800
Message-ID: <a87d41fe9b258cfede10727081fefdb1fd4f894b.1737511963.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1737511963.git.jpoimboe@kernel.org>
References: <cover.1737511963.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an x86 implementation of unsafe_copy_from_user() similar to the
existing unsafe_copy_to_user().

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/uaccess.h | 39 +++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a7755c1a441..a3148865bc57 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -599,23 +599,42 @@ _label:									\
  * We want the unsafe accessors to always be inlined and use
  * the error labels - thus the macro games.
  */
-#define unsafe_copy_loop(dst, src, len, type, label)				\
+#define unsafe_copy_to_user_loop(dst, src, len, type, label)			\
 	while (len >= sizeof(type)) {						\
-		unsafe_put_user(*(type *)(src),(type __user *)(dst),label);	\
+		unsafe_put_user(*(type *)(src), (type __user *)(dst), label);	\
 		dst += sizeof(type);						\
 		src += sizeof(type);						\
 		len -= sizeof(type);						\
 	}
 
-#define unsafe_copy_to_user(_dst,_src,_len,label)			\
+#define unsafe_copy_to_user(_dst, _src, _len, label)			\
 do {									\
-	char __user *__ucu_dst = (_dst);				\
-	const char *__ucu_src = (_src);					\
-	size_t __ucu_len = (_len);					\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);	\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
+	void __user *__dst = (_dst);					\
+	const void *__src = (_src);					\
+	size_t __len = (_len);						\
+	unsafe_copy_to_user_loop(__dst, __src, __len, u64, label);	\
+	unsafe_copy_to_user_loop(__dst, __src, __len, u32, label);	\
+	unsafe_copy_to_user_loop(__dst, __src, __len, u16, label);	\
+	unsafe_copy_to_user_loop(__dst, __src, __len, u8,  label);	\
+} while (0)
+
+#define unsafe_copy_from_user_loop(dst, src, len, type, label)			\
+	while (len >= sizeof(type)) {						\
+		unsafe_get_user(*(type *)(dst),(type __user *)(src),label);	\
+		dst += sizeof(type);						\
+		src += sizeof(type);						\
+		len -= sizeof(type);						\
+	}
+
+#define unsafe_copy_from_user(_dst, _src, _len, label)			\
+do {									\
+	void *__dst = (_dst);						\
+	void __user *__src = (_src);					\
+	size_t __len = (_len);						\
+	unsafe_copy_from_user_loop(__dst, __src, __len, u64, label);	\
+	unsafe_copy_from_user_loop(__dst, __src, __len, u32, label);	\
+	unsafe_copy_from_user_loop(__dst, __src, __len, u16, label);	\
+	unsafe_copy_from_user_loop(__dst, __src, __len, u8,  label);	\
 } while (0)
 
 #ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
-- 
2.48.1

