Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B73136347
	for <linux-perf-users@vger.kernel.org>; Wed, 13 Aug 2025 12:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755088049; cv=none; b=jZV2sesIhJ/7uCWKg1Cc09F+St+27Vz3NH9O5BF52MozwS9+UCfKRkCq9U48Rcq6Jv+E8gHnIyoy2c38hLDYFNBVuYZSTgBlKyqKIFQHs+XBn0ps6WdNfcX1fqY1bwU1sAuwKcekZlgz5yBZmjrqZCZVKOUoXlbEZST3gUiulz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755088049; c=relaxed/simple;
	bh=GbIxYmRopA1e1pkCw99AIa0AOpqQOxAdFJZSVIlkITI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=k9KECt75An/u0NHIDkExQw0agM400Sf2vcyaUjE7Re9I8GNUmD24w+ZDMhKLm6+CsFCd99rcRgD3DWxZNoFYEp7FsjaSzMJSSXn8MZnrIqi70OXzkaVM5FqktlhjXZeNRzfbNVfW9EdadkVLVZt3EoMWC976/6RjOpneScIDNaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFfpxGjG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFfpxGjG"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2430926b53eso9013925ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Aug 2025 05:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755088047; x=1755692847; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCRSIhSzDr4RKLGt92FHYYSQf942VJvJALBglFUAMhc=;
        b=fFfpxGjGZUBeNCM/fByRB6mPQt7b2fBCcXzXuvSUaJhGUBJExWJcSM3nei4UEiPA7H
         3+xTXrn2H+VVtXmbKWtrAUH2J2s3BrNWuzbkPwVpsJJxijdQefNrvP79sgjEwcKYgugI
         CmYiOAQ1ahjHoIpFi+vHvKpLQ9GWCzdLq+isZUjE7uw7xmA8c16N2d8dXcKlel0rciHT
         BOU/Xx0gdjZqIRJK+PogUK1GJrw4/+h8mbAa88BqZj0CtKMBYodsWQlViAnr0ipIasBD
         LnHT/5vhHRODhshMF/ZT4JvdkNYpykhdEpFK39E8Hl75hkbOmhHKtyLnLFWvZnZMVyD8
         xhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755088047; x=1755692847;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dCRSIhSzDr4RKLGt92FHYYSQf942VJvJALBglFUAMhc=;
        b=V6oZ/B9C8NgiPTJmmmS3Fmfb8MjDxOWHRqS38nT+YLlp8hvenRq786iuTgPtkug8So
         vFD6T6ej9nSyZcc8nga51ox322WPmM18GnWgTzwHRUJXVKhi6U0OAoPqw8QaUMTWKwvG
         Ppi2vgN6Bavt0oa+L7lAghYJyTp3rnrjvzGtxP5ZIZv5Qsr9u6/Xug11KR25/juh07n8
         5/+ou3yRrQtquItQVqdP3lUdiS3FRD8FnxVDtcRg2DxsCMzjG61f1LS3vbKkpwCAKCtg
         BKteB/jnsgKpAOsdEs7VJPH7KdpaMbAjEF6OwWZM70AxAi9nTjqgnslNYY/RzvvWMF5v
         urQQ==
X-Gm-Message-State: AOJu0YxNCoRaUdooKo20s5oPScBtNCTgCw0cnFajmfw36Wa1vY0d3BiB
	xjewKmDi9m4oIXL2KI7MD+9s75TnQ9+hl+ktCPG3JnlOtkso7c5M3PXdOXGPBQ==
X-Gm-Gg: ASbGnctBoU59O7AGt8N5WhwCDr9IzNxJST40akE2mjwuGJAAmU2H3GLnmyi91nBll6B
	ur48Pxz+hv2aHyC+xjzpaTlUA07irMaTJpBXhfcdhOUVGwG/8F80CkvBOO9C2yjVxyNnxOMGkbi
	KQsJ3+xjL7WJy7P+H5ZdXcev02L2B8mDLrKVAgdQghbEzc0VyF5Yk+Vsr1SjtOtNp5+TMBoYqne
	5Dirs9u3gKFbOzsDtYE5ohE7pePVhVDQ7kQLBtMp8thnGv++wPyCK460EW6ClJwwtyIVXApuBvT
	w8yHGtoS288H+yXytB+hkZ+mNXN6YGkP2m8EQflv1J7q2o7VO0gSwbixNmjpojV+NUjBscRWyjj
	Iw512XwEKSIC3uXKnl6gsLeuyIkcsuGyivW8=
X-Google-Smtp-Source: AGHT+IEan/2QdEZVsrN2M5rSU6ynytg77ubEyRTTnsfIThPVpEWHCMco+Wce2nG0m+tPsXLG23fFEQ==
X-Received: by 2002:a17:902:c40f:b0:240:9dd8:219b with SMTP id d9443c01a7336-2430d27e445mr49953705ad.49.1755088046475;
        Wed, 13 Aug 2025 05:27:26 -0700 (PDT)
Received: from [192.168.1.3] ([203.220.234.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899b783sm323279825ad.133.2025.08.13.05.27.25
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 05:27:26 -0700 (PDT)
Message-ID: <6312afd2-18d8-4e11-96a8-0ceed284634c@gmail.com>
Date: Wed, 13 Aug 2025 22:27:23 +1000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-perf-users@vger.kernel.org
From: Zixian Cai <fzczx123@gmail.com>
Subject: perf probe fails to add events due to "File exists"
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,

My apologies in advance if this has been addressed in newer kernels. Likewise, I realize that this might be a problem in kernel/trace instead of in the perf userland.
But I will appreciate any pointer.

I'm trying to use `perf record` to trace USDT events in OpenJDK (in libjvm.so). See the below entries in .note.stapsdt section.

 stapsdt              0x0000002f       NT_STAPSDT (SystemTap probe descriptors)
    Provider: hotspot
    Name: gc__begin
    Location: 0x0000000000874144, Base: 0x00000000012014f8, Semaphore: 0x0000000000000000
    Arguments: 1@$1
  stapsdt              0x0000002f       NT_STAPSDT (SystemTap probe descriptors)
    Provider: hotspot
    Name: gc__begin
    Location: 0x00000000008741c2, Base: 0x00000000012014f8, Semaphore: 0x0000000000000000
    Arguments: 1@$0
  stapsdt              0x00000031       NT_STAPSDT (SystemTap probe descriptors)
    Provider: hotspot
    Name: gc__begin
    Location: 0x0000000000874274, Base: 0x00000000012014f8, Semaphore: 0x0000000000000000
    Arguments: 1@%dil
  stapsdt              0x0000002f       NT_STAPSDT (SystemTap probe descriptors)
    Provider: hotspot
    Name: gc__begin
    Location: 0x0000000000874634, Base: 0x00000000012014f8, Semaphore: 0x0000000000000000
    Arguments: 1@$1

I tried
1. `perf buildid-cache --add libjvm.so` first, and then `perf probe --add sdt_hotspot:gc__begin`, or
2. `perf probe -x libjvm.so --add sdt_hotspot:gc__begin`.

Both result in

Failed to write event: File exists
  Error: Failed to add events.

Here is the verbose log with some removed for brevity. 

perf probe --verbose --add sdt_hotspot:gc__begin
probe-definition(0): sdt_hotspot:gc__begin
0 arguments
symbol:throw file:(null) line:0 offset:0 return:0 lazy:(null)
<snip>
symbol:rethrow file:(null) line:0 offset:0 return:0 lazy:(null)
symbol:catch file:(null) line:0 offset:0 return:0 lazy:(null)
Parsing probe_events: p:sdt_hotspot/gc__begin /home/zixianc/jdk-21.0.9/lib/server/libjvm.so:0x874144
Group:sdt_hotspot Event:gc__begin probe:p
Parsing probe_events: p:sdt_hotspot/gc__begin /home/zixianc/jdk-21.0.9/lib/server/libjvm.so:0x8741c2
Group:sdt_hotspot Event:gc__begin probe:p
Parsing probe_events: p:sdt_hotspot/gc__begin /home/zixianc/jdk-21.0.9/lib/server/libjvm.so:0x874274 arg1=%di:u8
Group:sdt_hotspot Event:gc__begin probe:p
Parsing probe_events: p:sdt_hotspot/gc__begin /home/zixianc/jdk-21.0.9/lib/server/libjvm.so:0x874634
Group:sdt_hotspot Event:gc__begin probe:p
symbol:throw file:(null) line:0 offset:0 return:0 lazy:(null)
symbol:rethrow file:(null) line:0 offset:0 return:0 lazy:(null)
symbol:catch file:(null) line:0 offset:0 return:0 lazy:(null)
Opening /sys/kernel/tracing//uprobe_events write=1
Opening /sys/kernel/tracing//README write=0
Writing event: p:sdt_hotspot/gc__begin /home/zixianc/jdk-21.0.9/lib/server/libjvm.so:0x874144
Writing event: p:sdt_hotspot/gc__begin /home/zixianc/jdk-21.0.9/lib/server/libjvm.so:0x8741c2
Writing event: p:sdt_hotspot/gc__begin /home/zixianc/jdk-21.0.9/lib/server/libjvm.so:0x874274 arg1=%di:u8
Failed to write event: File exists
  Error: Failed to add events. Reason: File exists (Code: -17)

Here is the content of /sys/kernel/tracing/uprobe_events after running `perf probe`.

p:sdt_hotspot/gc__begin /home/zixianc/jdk-21.0.9/lib/server/libjvm.so:0x0000000000874144
p:sdt_hotspot/gc__begin /home/zixianc/jdk-21.0.9/lib/server/libjvm.so:0x00000000008741c2
