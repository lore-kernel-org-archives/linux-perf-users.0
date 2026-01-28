Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1530A2DC32A
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Jan 2026 03:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769572372; cv=none; b=Lz1x/p7V/PrRuK8iLKAniOI4MRYDZ16GxReWd6N63SeAozcavVGZF3Mz7bqCsNwpcfkZsnyQ/KAkQCshQOTGiyo1xL2oxWHLoEbOQdthKVepVtowhnI4WTxUwdp/zhheQMGtqAyI/CFxj8LV492GkmdDzkT6cCVUruTBXmXpiqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769572372; c=relaxed/simple;
	bh=jSdlqSXMehB9BbGIf+CvOfSjGhjSiz8lASujmMLi4AQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BFH5MaSt/hVmZcKOOlKL96qOVTTBDG4bYwJ642uYbPfcPSQ3xqCqse9P2Y/CaTVEIgDwJ3yYPfiVG1tOW/rj257hOm2jfmeZZ7u7zDutJfaX026Ef446Ym968ypagbgsbEm4VSZQruFXSAy4g+xUBlj1wvaw8+4gwitGWWqohwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WN9XXBY6; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WN9XXBY6"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-8230f2140beso235732b3a.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 19:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769572370; x=1770177170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzjZmQg+KemvQlHGb9aPeU+IfGIuMW24Vm0tVU7jCyw=;
        b=WN9XXBY6d63jHWm2yhojEr4VLCyzBdgYCDNdnEnrH06Mj6s2St4lq9tqGd+7/7L6+9
         otH7YqbcLYg4W0L/uYuMk8mxsCWW4qrTOI6zDB4M43818AT2+cHDmc9SJilvX/mED3Ga
         04OSaxJMkg1Utyxkmfz0phi+fN27GBpwtaklnvMPfofOLnThrILliBuRIEpU87PLWVi0
         GLQRobYReVvYG1nx+3ddwNZA+djarlfViJVQLVqvuUhFMCx4P3a5tOCncLM5mhmnJB1o
         b486NtcIPFDViYbCryE8E89fjQm7B7XMR+dHbDLG99NQJuIkFzItGngB5DQoKYZH7fGZ
         052w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769572370; x=1770177170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vzjZmQg+KemvQlHGb9aPeU+IfGIuMW24Vm0tVU7jCyw=;
        b=VqScIjSvQVrAz6iFNZn4H0zRYbUjogFjR1lQ7gWCMBeO5vlsvLIoKUc/k636OcbeH6
         KcSmqabSswtc6jCLTYRTTx9m0MWnKyzxO2UzBddkKUKFpYlsZBFWArphkELKEmjY6GnE
         8/AvOx3L5ejExGu1zFyKpaM458htHBLjp/oyI0EjCO8PX3G96aTAYHHUPDz3Z2/o/aNc
         aUHwcTC6O3+tAErHV1c82Jr3o1NU8bdIbo2RNVWsugdVBfHGTuCEGGzAkooQB8RJXeL2
         XDevKL7Eqxf5MAg7rqPQf33q3XymMlD6eOYHAg/eubO/KM8Qgzg9DXI7MtEe9sh835i4
         dIzg==
X-Forwarded-Encrypted: i=1; AJvYcCXPD666nV5zY+T7AtBYeVklgaFIKXe5ndhr2v+fpaOgFLoJuK8AI3HQfi/ryh5H3YPpsynvDWBh6Pe0H16IOF+F@vger.kernel.org
X-Gm-Message-State: AOJu0YyJCejqROMYSmCzcydRjqXjfraX2c4J/e9UgbbR+G7/QYROAbz2
	Gf3ILvCnUORZxSYI+gqCTxlKeeNKCHp42El1xJ+CGQcbbJKV5sbArTSi
X-Gm-Gg: AZuq6aIOdAUnezfzZdXsakKhDGVqs2gLCp0Z5qelvhTfN+voTXZ613RyrJgo5KKRTbZ
	mr5yk5DXn0WsFg0z1t5mmSYwkB+70BtDYufDtcQ4EoZIq/RWl9Ve5+/eAkVSZmb9JYiF9KjN+OW
	qYlV8JY7oEIP7sF/ZAnyK4D4Y4s++5pz2beZAS7byNh5lkea1YfNnIFjKzrHNwvCTMYW8T8uwJ3
	iMlh7zAXFKD6vqQvqFp9L71EtuwQD+paBk1j3hQ1JQXjKSkp5SK/WMTlqODz/cS280vSO0NcUkM
	IOt31o6ANaafl48RpyOSy61nfoqTZFaYxl1nCzGeLSGP3oCH5q4fKKtU2YS1kKuyHMu9pAv+D66
	CygDizIU/+9fozVdE9Fs20SRRpZwgC3PF088nn9GzBqA2Y7oSboiyn9gaB9G1ZtRByidzK0aikl
	KIEXgg/sDFd/thdIaFMjVPH5x0xwp7vXlmHCWqwg==
X-Received: by 2002:a05:6a21:2d4a:b0:35d:8881:e69b with SMTP id adf61e73a8af0-38ec5e7b92bmr3895558637.18.1769572370480;
        Tue, 27 Jan 2026 19:52:50 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.220])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a33566csm759883a12.21.2026.01.27.19.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 19:52:50 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	peterz@infradead.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [perf?] WARNING: suspicious RCU usage in get_callchain_entry
Date: Wed, 28 Jan 2026 11:52:41 +0800
Message-Id: <20260128035241.1839686-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000fe324606174e1f9e@google.com>
References: <000000000000fe324606174e1f9e@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index da3d328f5c15..6e53c2d916cd 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -460,8 +460,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 
 	max_depth = stack_map_calculate_max_depth(size, elem_size, flags);
 
-	if (may_fault)
-		rcu_read_lock(); /* need RCU for perf's callchain below */
+	rcu_read_lock(); /* need RCU for perf's callchain below */
 
 	if (trace_in) {
 		trace = trace_in;
@@ -474,8 +473,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	}
 
 	if (unlikely(!trace) || trace->nr < skip) {
-		if (may_fault)
-			rcu_read_unlock();
+		rcu_read_unlock();
 		goto err_fault;
 	}
 
