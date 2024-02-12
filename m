Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A04347A7D
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Feb 2024 18:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707764358; cv=none; b=DYdqUsYU7kOXELFSOFt3fGbLZDZodYv9r7/Ol69JTeIjxghIRrPKjsXBkNfYI2xOmTKtyG5CbwpxyRDXA25WEeE6fLtN6Io4iVZeklMJ4yZYn6x9mTMCd1ePkcMg1UHS8EPBtvq4BbHUM3bSoM8pQAkkzHMmvMAu+XXxytWes2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707764358; c=relaxed/simple;
	bh=LBou+XLQ8QDVF7i9zNrb0c+TC2HDLKGD9kRdzvqDd8M=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=kms5ox0Aga1J+Dv1rTESMbagoCDA4483bO8ur0EywbLSV/4mhKcG7AmSjnOfuYZ5p7U85mC10LlPF4hOAVE+qtfHks3jf2WiEGEsxRJMkJui5PODsLMkub8pGpKl8hfqZfIVFA9WmGOce1UfZNBm9WaDKXe6uZMm9FiztYWPCRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HGs80CWM; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HGs80CWM"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc748365ba9so5189794276.2
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Feb 2024 10:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707764356; x=1708369156; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FAs57lgcOMUxLgf079L8itwe0kfFXp2CsT7fDYu4PDI=;
        b=HGs80CWMzD8pcAUY1jRbxc/aYbownwLRYBYA83vBUAtJYVtFpKvup9XaGpO0muRX6S
         dtKmOKiTT2Mon+xo0DqCzxqKnyBx0luCM/Xuig3+tVnlA2laEzAfIJNyOar7iTrQ/vcV
         Bdc06BggdZddTwXW6xjZSVlXdU1VRLoSb8jOY541/2W8c3GV0SdOthe3si8zT1IvkxLw
         k4u5C8CcsVG/3oS62NCzBMXW1pizYRfKPV6nTk4PmjyOauAthQ7oaUfiCDrZPKR9Y0tk
         FAXHVuUaOz8ik1VrvH5YENVMP5MHwLqoBMz7HhbN/uk1YF+qLZ5fExsY6bEs0ERXPK8k
         FWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707764356; x=1708369156;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FAs57lgcOMUxLgf079L8itwe0kfFXp2CsT7fDYu4PDI=;
        b=hBifUQOXqOw+tZKTzmPPqqoJDnQXIOUk8uEavndCYIv0YPwUNz/VNB2gDYJWsIz3Sr
         yZIqpKEHC8WOSM3unyRvw7YAJiQ6vBjDfaN2RT9RMOQg0DBygjiiYH6wtWgNxMaAg4kk
         YFpF8JdCAwQLWJ8i9FOyWrfxHnAnLJcGob0nuavv3FLiYFoLML4s6PaVquvjsqzlZhjq
         hwGnu3dCrjoN4oZItWwXNe34X8UQIFyd50k6ebsZo/N/IFUbnsQxL4pcJCPQglgDxkKg
         zqnRUytL2Cr4ESa6Zt/Ep3ScE1w7dvYnkTXFnGZakbA+96QTKAxF5QT+vI6vH4N1VAu9
         Ixvw==
X-Forwarded-Encrypted: i=1; AJvYcCUAF/IwrPCHZA/dlmgOzqepXaNnDVw/Xzau8IjSM3Tx9JIcg7suBZcDD3WqblK2OCOB1WdQPu2i43DXlhS3dzegWuwFJKVTbUwCwZP1RtMOjw==
X-Gm-Message-State: AOJu0YwwB9hYR/A1bvfp4yvY3qkcf4lImjUz6Ev2OmtRBeY8M/AUCIPb
	4uhywP8KQgnNgy6AW0cPFqcpZ8N2sKtp+DK17GfX+SXSCCUKhPSj9oXjqjNpIvSSFZ6Fs9rHADg
	fJPXz7g==
X-Google-Smtp-Source: AGHT+IFKUUMT3n7DkY6OIeWV+e7Wky9FtU2Gzr+NBHztBUsnln24BvN1I4nBHu3pAe9rRC8RqMKIOJHyh6k+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:125c:bcda:4fe2:b6e6])
 (user=irogers job=sendgmr) by 2002:a05:6902:1007:b0:dc6:e20f:80cb with SMTP
 id w7-20020a056902100700b00dc6e20f80cbmr348338ybt.3.1707764356106; Mon, 12
 Feb 2024 10:59:16 -0800 (PST)
Date: Mon, 12 Feb 2024 10:58:54 -0800
In-Reply-To: <20240212185858.68189-1-irogers@google.com>
Message-Id: <20240212185858.68189-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212185858.68189-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v3 4/8] tools subcmd: Add a no exec function call option
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	James Clark <james.clark@arm.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Tools like perf fork tests in case they crash, but they don't want to
exec a full binary. Add an option to call a function rather than do an
exec. The child process exits with the result of the function call and
is passed the struct of the run_command, things like container_of can
then allow the child process function to determine additional
arguments.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/subcmd/run-command.c | 2 ++
 tools/lib/subcmd/run-command.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/run-command.c
index 5cdac2162532..d435eb42354b 100644
--- a/tools/lib/subcmd/run-command.c
+++ b/tools/lib/subcmd/run-command.c
@@ -122,6 +122,8 @@ int start_command(struct child_process *cmd)
 		}
 		if (cmd->preexec_cb)
 			cmd->preexec_cb();
+		if (cmd->no_exec_cmd)
+			exit(cmd->no_exec_cmd(cmd));
 		if (cmd->exec_cmd) {
 			execv_cmd(cmd->argv);
 		} else {
diff --git a/tools/lib/subcmd/run-command.h b/tools/lib/subcmd/run-command.h
index 17d969c6add3..d794138a797f 100644
--- a/tools/lib/subcmd/run-command.h
+++ b/tools/lib/subcmd/run-command.h
@@ -47,6 +47,8 @@ struct child_process {
 	unsigned exec_cmd:1; /* if this is to be external sub-command */
 	unsigned stdout_to_stderr:1;
 	void (*preexec_cb)(void);
+	 /* If set, call function in child rather than doing an exec. */
+	int (*no_exec_cmd)(struct child_process *process);
 };
 
 int start_command(struct child_process *);
-- 
2.43.0.687.g38aa6559b0-goog

