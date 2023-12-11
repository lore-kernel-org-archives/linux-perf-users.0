Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcCjBPdl"
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E9698
	for <linux-perf-users@vger.kernel.org>; Mon, 11 Dec 2023 10:01:27 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1d2eea4af93so7055185ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Dec 2023 10:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702317687; x=1702922487; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m8ov5rUuh1DCcAbVaXZE62Q7sBBAz9vzZxmSXeBpC6w=;
        b=hcCjBPdlANuU5YOO8fam9M+zzDf3pli0LqAgQrT0HXCfjgO/sqUVM53h0VITrWQzxt
         MXyBWcmc5TuEZKPQz+sKqduFDMh7EaBfAvAD5mFGx/PjoljQpAcpWeif0tW8689yyXpJ
         RteDQKdTw79gUe83ZsLe+bqsBtyYsaevS6bEMACSihA3GRY8+0OitXS4UN1H8iPhDaFI
         TEbkNuoscfno9XpVlw/J99k+qsYjSo+m4pJBTfndXCVcS05f/70rhfqHB/mdHrEm1J6y
         e2NCzTnEd1poklWBKhoCr8Iolh7jggFCdkR0SuKcJVejq5uscmJH3trUETN3Y/ikbc5+
         4rLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702317687; x=1702922487;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m8ov5rUuh1DCcAbVaXZE62Q7sBBAz9vzZxmSXeBpC6w=;
        b=nrw1n6S5EZGl+xRfWSoAqroogo7+ujcdjAhfZvXSDcCIK2rZGTPbs4BOc0fUuEJZVb
         AWZZUWv9GTDtYYjlxFaypPrgzEfvzcB7iK06NiFrd6tv4989GovMfA0L3up/Gd2IvwvQ
         B8CDkVext1gRfHRXbFYqETTgq5EkoNWi5delOMIfVLdKlEBGSHprpQGFv8eGSxtALg5a
         t5uItcE7QsRIll/2Sx8SnS7L1SjCuq7Yyx5LGSVhBtJ7ZNsADc0t2Q7beAO3ytslLXBJ
         VqcFDQDCv2IAdaRvHeIAmBxepYJBJ5z1n7ATuHFU2tFWwtQoeNv2Dgmzf/27Mg+OlXPM
         jZ9w==
X-Gm-Message-State: AOJu0Yy2L3AX6pbrVGqE3ORsrHiZjc5+pClX3Leo630fLrY0oIpfEkwx
	AgccLoef/bRkJtLfYfVvJwzPZCiWZFCiS9JF2+oqfQ5W+VY=
X-Google-Smtp-Source: AGHT+IFOH8zja7KL8AUwuj/hEmOLoMxJj1VhNWodowvmcCVgvmeqKKF4cMfeIXMZD6U7Vd2wNWjNja/GR+oQ7IfR13U=
X-Received: by 2002:a17:90a:d794:b0:286:f1b8:da7b with SMTP id
 z20-20020a17090ad79400b00286f1b8da7bmr8174099pju.0.1702317687077; Mon, 11 Dec
 2023 10:01:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: trinity pointard <trinity.pointard@gmail.com>
Date: Mon, 11 Dec 2023 19:00:51 +0100
Message-ID: <CANiTRwdm56EJkY=HN+OnD1y++MT6zxEpX3dqoThELMRsUyFTEw@mail.gmail.com>
Subject: possible regression in perf
To: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I think I found a regression in perf related to the control fd.
At its introduction (bee328cb71eb0b38ab128d7c475209d973a13f92), it
looks like enabling or disabling counters would print the current
counters. However when `enable/disable <counter>` was introduced
(991ae4eb36911fe9a99bef1c22b9578ceec3896a), it changed what
`evlist__ctlfd_process()` would return on a successful enable/disable,
which made the call to `process_interval()` in `process_evlist()`
essentially dead code.

I was in the process of patching perf so that `snapshot` would print
current counters (in which case I would send enable, sleep a bit, and
send disable+snapshot, to do my measurements). But given what I saw, I
think just sending enable and disable was enough at one point.

Is this a known issue? Would a patch which makes
`evlist__ctlfd_enable()` return 1 on success be an acceptable fix?
It's somewhat more verbose than what I wanted initially (printing both
on enable and disable, printing on enable isn't useful to me), but
that's reasonably easy to post-process (or enable could be made to not
print current counters).

Regards,
trinity-1686a/trinity Pointard

P.S.: this is my first time posting to LKML, please tell me if I did
anything wrong :-)
