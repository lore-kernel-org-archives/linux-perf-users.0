Received: from mx-8.mail.web4u.cz (smtp7.web4u.cz [81.91.87.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5CC286A8;
	Fri, 19 Jul 2024 10:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.91.87.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721386637; cv=none; b=XiQOltkLeEawKIHAqqj2xXSYECtEdVWq7eMh58MT9Nt+JMRvss0ywfo1HMWWswBf42JrGexHNs6xE9Fp5yF4u0LfRp/Jsopsoupi3IsKMplv3dkwhOXkDRVdf3gZVumVFCocqSDKelzVJ8PNhp9vGow1Pklmgju3X7e+TmstDGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721386637; c=relaxed/simple;
	bh=XqdviDdEGP/p3AysBZArv4kw5UGx1r+Y8TPZZs041Os=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=erV/PQRxXEZ/4SkwfIoqKn+fCxVDpi+oODiuyjSg760GDbvydkQiORTf+BvPNx5xmRQD2N1uZYVDqBOlBsUSPNLY+0JXfBuh8cD0C1Fs1HIHaxHoZD5Mt+81xVsm+3jg7ibyUWjsLTDFVsN7XKectawyA3dSCBDTkQw4RLN7u1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=foxlink.cz; spf=pass smtp.mailfrom=foxlink.cz; arc=none smtp.client-ip=81.91.87.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=foxlink.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxlink.cz
Received: from mx-8.mail.web4u.cz (localhost [IPv6:::1])
	by mx-8.mail.web4u.cz (Postfix) with ESMTP id 6835A1FFCC1;
	Fri, 19 Jul 2024 12:57:08 +0200 (CEST)
Received: from [192.168.0.36] (unknown [193.86.188.206])
	(Authenticated sender: m.liska@foxlink.cz)
	by mx-8.mail.web4u.cz (Postfix) with ESMTPA id 329631FF5D6;
	Fri, 19 Jul 2024 12:57:08 +0200 (CEST)
Message-ID: <eadc3e36-029d-4848-9d69-272fe5a83a26@foxlink.cz>
Date: Fri, 19 Jul 2024 12:57:08 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Martin_Li=C5=A1ka?= <m.liska@foxlink.cz>
Subject: [PATCH v2] perf script: add --addr2line option
To: irogers@google.com
Cc: acme@kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, m.liska@foxlink.cz
References: <CAP-5=fXPC+pXmJCpvkr5x2Ae1hdKeL7Cd6Uak+7mn+uG+R8yVQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAP-5=fXPC+pXmJCpvkr5x2Ae1hdKeL7Cd6Uak+7mn+uG+R8yVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-W4U-Auth: 537b5aeaff86ab268f05b418454acd133d65e008

Similarly to other subcommands (like report, top), it would be handy to
provide a path for addr2line command.

Signed-off-by: Martin Liska <martin.liska@hey.com>
---
 tools/perf/Documentation/perf-script.txt | 3 +++
 tools/perf/builtin-script.c              | 2 ++
 tools/perf/util/symbol_conf.h            | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index ff086ef05a0c..5abb960c4960 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -369,6 +369,9 @@ OPTIONS
 --demangle-kernel::
 	Demangle kernel symbol names to human readable form (for C++ kernels).
 
+--addr2line=<path>::
+	Path to addr2line binary.
+
 --header
 	Show perf.data header.
 
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c16224b1fef3..932167b2362b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -4052,6 +4052,8 @@ int cmd_script(int argc, const char **argv)
 			"Enable symbol demangling"),
 	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
 			"Enable kernel symbol demangling"),
+	OPT_STRING(0, "addr2line", &symbol_conf.addr2line_path, "path",
+			"addr2line binary to use for line numbers"),
 	OPT_STRING(0, "time", &script.time_str, "str",
 		   "Time span of interest (start,stop)"),
 	OPT_BOOLEAN(0, "inline", &symbol_conf.inline_name,
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index c114bbceef40..d41b25e10f1b 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -63,7 +63,7 @@ struct symbol_conf {
 			*sym_list_str,
 			*col_width_list_str,
 			*bt_stop_list_str;
-	char		*addr2line_path;
+	const char		*addr2line_path;
 	unsigned long	time_quantum;
        struct strlist	*dso_list,
 			*comm_list,
-- 
2.45.2

