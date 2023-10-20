Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E31200D9
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Oct 2023 21:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rb/qJ7HW"
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BECAD6A
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Oct 2023 14:21:29 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6b1e46ca282so1237265b3a.2
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Oct 2023 14:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697836889; x=1698441689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5A2KGr1//Sug9d1kfltYNWIKYBNDoz4bih0PnnpI7Y=;
        b=Rb/qJ7HWv8POwq6RfO3yj32vF9yyCuEz1ohmaC2nckrn/rnqLP/MBFBzYpEI15lwcW
         dWnvdminPL1EOu/iUSuXzUsYL+2JBJSg4Xtfs6m1M6cgsPVuV3y3XSf6+JsD7E8OKB2P
         k46K6y1tYrlvEVeiLG5kSfX0ofLE0SQHnpR5WetRtqzKDAX1ubssvtKr5e+d9vZx+JdI
         EaYKy47STEJ/k3saMXjFTcmO5OuMyK61SaoKIVGznPWdK8OyrcUOHK58bRNEGUhKm9KZ
         P+oEIGx2n2AxABlBOJVs1aDsh0RTqOopSX5IlT9IpvXee3QspozvG5s3DATmKQqo8eZK
         q8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697836889; x=1698441689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D5A2KGr1//Sug9d1kfltYNWIKYBNDoz4bih0PnnpI7Y=;
        b=v8H/OTr4eIRb2RWAjErTxCYbVoTPKF+JsE3EA6NB+0L4Rd+aseIGrsGUGRg16Fqnig
         +tUvXrzBzOrAAH32Z0ghoXHKmpKzcpsfWv15zZUTB1Q6/thFKvz2Tb2TY3TotQW83txm
         rlOYtNAB3XAcx/UD7SaRkWaZLN4+9ESau0qZjnPjhwuOesMzGCmYw7ey091c9L2M+3g6
         KKJ/t2zQ8RDEbfbkMVHC0+jtwbSeclHA98vjdOFufxZX9Sm+moSy4D/r2txt3klDE+RK
         BxqZm+qWDmfSe7XTSwWn80FUIbibJWmWEhUCxkUkcX9k3el9mY0JyVokINmaiG5/mUsg
         BGAQ==
X-Gm-Message-State: AOJu0YwEFQW4KpEvwWetbr/kIVJo/kj74RBXdYrjsPTq5a/W4sOmrL5J
	yoq9pE+tuAmWv70pl19uau0=
X-Google-Smtp-Source: AGHT+IFFRWQ+xhY+lyL6E2NRQML/OhQy8/0ZWP7LZAc1J8O8Ft2QlWoM4IyTJci0q3laR2IxNq7m3Q==
X-Received: by 2002:a05:6a00:cca:b0:6b2:69c:346a with SMTP id b10-20020a056a000cca00b006b2069c346amr3396718pfv.19.1697836888849;
        Fri, 20 Oct 2023 14:21:28 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:5cd3:25e1:1589:ad95])
        by smtp.gmail.com with ESMTPSA id p9-20020a63e649000000b0057412d84d25sm1919583pgj.4.2023.10.20.14.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 14:21:28 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org,
	Kajol Jain <kjain@linux.ibm.com>
Cc: Disha Goel <disgoel@linux.vnet.ibm.com>,
	maddy@linux.ibm.com,
	linux-perf-users@vger.kernel.org,
	disgoel@linux.ibm.com,
	atrajeev@linux.vnet.ibm.com
Subject: Re: [PATCH] perf vendor events: Update PMC used in PM_RUN_INST_CMPL event for power10 platform
Date: Fri, 20 Oct 2023 14:21:14 -0700
Message-ID: <169783679853.2217970.13950056970410298391.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231016143110.244255-1-kjain@linux.ibm.com>
References: <20231016143110.244255-1-kjain@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 16 Oct 2023 20:01:10 +0530, Kajol Jain wrote:
> The CPI_STALL_RATIO metric group can be used to present the high
> level CPI stall breakdown metrics in powerpc, which will show:
> 
> - DISPATCH_STALL_CPI ( Dispatch stall cycles per insn )
> - ISSUE_STALL_CPI ( Issue stall cycles per insn )
> - EXECUTION_STALL_CPI ( Execution stall cycles per insn )
> - COMPLETION_STALL_CPI ( Completion stall cycles per insn )
> 
> [...]

Applied to perf-tools-next, thanks!

