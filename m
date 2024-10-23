Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC36515746E
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Oct 2024 21:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729720642; cv=none; b=ZvtzWOcKODJ4DcMyZ2K4swqFynt+hZpcwOtraoAGcGWk9qYAM583hptILGudbyfCSUCTL6ebRiqfmd/SdaBupFuYNu4opbw8F9+BFAtqxG1bqPDV4E5IRAgTYjJIavKGAyA1SO+0fbaIOJIXC6HKEDHKt7SK9Yn35eU+DZnV42o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729720642; c=relaxed/simple;
	bh=T2xGFeke+iOeRxlPLeuSO4msAVCygbsF7AoDY8kGvj4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=j5cqdX/i34o6oMp2nbVQ99A9yzNA5yu5iPRiO1lZy9FHLwHjTmwZBxGkQRoahJV0o6nR1HK/UxCAgnOhLaEgWzOedECKc6EbSF5OSmp1DIMpN5iDoDgO4CwaKscpY7Y29QZ7CRsp8WCCmIgktVoFtBuGHFrNEozhVUQ52m41P20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TGmxMYmW; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TGmxMYmW"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20ca03687fdso20575ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Oct 2024 14:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729720640; x=1730325440; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T2xGFeke+iOeRxlPLeuSO4msAVCygbsF7AoDY8kGvj4=;
        b=TGmxMYmW7fY1Ndc1oZyex27pAVjZ/6D5CegvyDy5DsrJhYSYSH7DclC+ZGqKB+S+jI
         vI2kS9tKlEdz66N4Tr9bW9efrrT8U2BlPSIRf7irpzfYSqrsbhiukAeAH5nUG6RqKYh7
         64bcRtTc5/gdN/r+MkH88HcEE9TaPGDQfCkLX+v6JWXn7+00ESO+yHhWiXGXqbBrYJJM
         WUdBn1ENwWmlK6WrrbTRI/lQ7YdDo8MRA0W5z2KGFR9Urc/ZP/8Up1TDu/SLvxr8pRo1
         Nn/uVVqS/eKpxPBmOj2c6vudWtf8hk0lFICLaUnxVp8H477JNygjIsjfcXkXQHimGHIA
         QU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729720640; x=1730325440;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T2xGFeke+iOeRxlPLeuSO4msAVCygbsF7AoDY8kGvj4=;
        b=U0gwfbTIsSAEeb9WG4FTNZQ/Y30k79XQQKr60Mbf20AQvSIJ7D0UcUvBG5WDM+v9j3
         XUD2gtgUCK4UOEHB7k7xj8yTLA0fmWiRRWL0hV88UKjMTlyQNp1msSVAIFwzXzi1H6um
         IdQDkS62QDJ4dd+CzqWCz1Jfm01q6qp+1RTLMlRXf4AYqH94UxIPzSz9N0AiavDT4pVL
         Af7wRJ97XaQThNeT/4gSw6NBAPRgt12RnfBOjOnIwXeveeOcYp+6yBkITq1ebmqlfY0j
         PQebNbYSrLe9w+5hUcmnYufyzT3CpbG077he0bXRULTuupOyYwoLMUfVBm+PtmRj2PiP
         yaTg==
X-Gm-Message-State: AOJu0Yxr4ZVu3yAIh6mc6fItpNMSXPFc4rcnTSeQueM0PtBDHJMFGeOO
	KOMq4y7bOmPnRNtxVOK+5X7VwV6CH4infdDEf7vfFuY10NjDD2ZaV+D4SIaJoEoytCKaWpb6oDR
	UfW2DWxbCw7wNPD5jWmRKBT2nxSPa6VfDAUCQRc3Ydcpv3A6rdVhQ
X-Google-Smtp-Source: AGHT+IHb+GNhExJ6XL0/O/4j+1Sprd3Xd3ItgM0C3NqKj/6u+HgDJeL5Wd7o9FCedGVBCmoWFPdgUzQHf37JbmVdip0=
X-Received: by 2002:a17:902:ec84:b0:20b:bf5a:c8 with SMTP id
 d9443c01a7336-20fb5eca2edmr1010835ad.10.1729720639450; Wed, 23 Oct 2024
 14:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Oct 2024 14:57:05 -0700
Message-ID: <CAP-5=fUXkp-d7gkzX4eF+nbjb2978dZsiHZ9abGHN=BN1qAcbg@mail.gmail.com>
Subject: Can perf drop libunwind support
To: linux-perf-users <linux-perf-users@vger.kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

perf wants to build with BPF support these days. libbpf has a
dependency on libelf, part of elfutils. libdw is also part of elfutils
and amongst other things provides unwinding support. My understanding
is libdw unwinding is used by perf in preference to libunwind when
present. My suspicion is that libunwind is being feature tested,
linked against but then seldom or never used. Given this could perf
drop libunwind support in order to simplify the code base?

Possible savings:
 - remove libunwind's 8 feature tests
 - removal of 10 arch or not libunwind C files in perf
 - removal of libunwind #ifdef-ed code throughout common files.

Thanks,
Ian
