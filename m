Received: from mx0b-00164701.pphosted.com (mx0a-00164701.pphosted.com [67.231.149.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B2723A5
	for <linux-perf-users@vger.kernel.org>; Sat, 30 Dec 2023 10:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=usc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usc.edu header.i=@usc.edu header.b="woVJjuIX"
Received: from pps.filterd (m0085734.ppops.net [127.0.0.1])
	by mx0b-00164701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BU6WZ2n022024
	for <linux-perf-users@vger.kernel.org>; Sat, 30 Dec 2023 02:26:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=usc.edu; h=mime-version : from :
 date : message-id : subject : to : content-type; s=pps23mar2020;
 bh=37zeTRR8EDU/u7Blovh1kUlktn6PB37YBajI/uZ6wyQ=;
 b=woVJjuIXIedPodiZiqLupdchlAnpPSEuwCLb8RkC95uIM9xCZCpVDxeOT9rvBXSEyM5q
 LqFKQ2xjtnGKI4jX/JrJ+gBrsSJFoGsKA7AtvoxwEvC8qp0JKJfEoC0La6NOreIL4YId
 jSGYqkkzdTgQA5CK4gl8HL4kzvJalVqIwERtBO0oNx836lFE6BHBan1w3l4su4AOxEAn
 PzHr489Vvoo5tGBH2JdlOpiTyHIhj0uk6rSyT1ca+piKahdZC/6JHtQrKSz925wawfTw
 f5kvzJfT3Hhb35CAF6t0G73GRR0VqXAU8SAXURbKplI8Z2Cgm1P83xiHnVZFTDs78STS KQ== 
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
	by mx0b-00164701.pphosted.com (PPS) with ESMTPS id 3v8y9ykwp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Sat, 30 Dec 2023 02:26:08 -0800
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50e879c6b34so1682205e87.0
        for <linux-perf-users@vger.kernel.org>; Sat, 30 Dec 2023 02:26:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703931966; x=1704536766;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=37zeTRR8EDU/u7Blovh1kUlktn6PB37YBajI/uZ6wyQ=;
        b=GCnLhzChH71DbHyAQGdoMQCvJh5zWjMGR9GVCR5gU8ZwD9K78T5RxOak/eEhMZP0H9
         J9qo+Czeo3BzPQfIHEQGbT8Rx0ZQi/lAuamwrC/Ld94v0P8VSCFrsk34l6gcCWergkeT
         gvYwPW58fkVErwz0jjl1JpfC41/OX+CQkCad9mzJok+pw2OPryjyH/WDNssbaNCJnR92
         Uw/ulcSnlqoCHRIkWJnZeblx+7OO+wrJrvC6QkJnF+GhCnTJ7LV9tIH1krv2LzqIUrTg
         uM1rN09qOGK40W5vs2N0QWZPptympVDLrGPpjy5hQLTWv2Bp9uTQR0nt7Le0YTOLSTra
         XxRw==
X-Gm-Message-State: AOJu0YwZUpmANUT4ljkaMF2atYF+KaUNgwrLOKdP5Kz3Lmtci0jZYywR
	h4F6GYU+wvCKxwc2tzuw1G9ruMbsvlVZ0MnJCl/LER3zyqAiymZ3t2ABnyfk06rQpc08CtP/3aG
	lVKVC6JftqMl7bCh5dzhaCdXeOqWe+bSHIN7l3FfiHVC55V8fZssh4cgW6EN/5KM=
X-Received: by 2002:a05:6512:1282:b0:50e:7e2d:1740 with SMTP id u2-20020a056512128200b0050e7e2d1740mr5262771lfs.3.1703931966255;
        Sat, 30 Dec 2023 02:26:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYB+Z5C0+SdY9NJ6C5zHJJlP343n4XYV1saT8nJkjj/tt8TlJqbsxMRs2/oOhcgJQZTPNTmICFZVn+7j0xpUY=
X-Received: by 2002:a05:6512:1282:b0:50e:7e2d:1740 with SMTP id
 u2-20020a056512128200b0050e7e2d1740mr5262767lfs.3.1703931965924; Sat, 30 Dec
 2023 02:26:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yuzhong Huang <yuzhongh@usc.edu>
Date: Sat, 30 Dec 2023 02:25:55 -0800
Message-ID: <CAMRy72f0kF_8-BoJfb1_qmpgMLcNFmzPhYQaury_XeDnhPPXxA@mail.gmail.com>
Subject: Unable to run `perf stat` on Intel hybrid system with e-core (atom) disabled
To: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: GaIZa6htISfjlOCu4YAPCf5UCuc9XG6e
X-Proofpoint-ORIG-GUID: GaIZa6htISfjlOCu4YAPCf5UCuc9XG6e
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312300087

Hi Linux Perf Users,

On my system (intel 12600k), if I disable the e-cores in bios, perf
stat command would fail:
> root@localhost:~# perf stat sleep 1
> Error:
> The sys_perf_event_open() syscall returned with 12 (Cannot allocate memory) for event (cpu_atom/cycles/).
> /bin/dmesg | grep -i perf may provide additional information.

Looks like it's trying to read some counters from the e-core (atom). I
have tried `perf stat --cputype=core  sleep 1`, still doesn't work.

I notice that if I do a system wide `perf stat`, it works as expected.
Other perf tools like `perf record`, `perf top` all work as expected.

I have run `perf list`, which does include all kinds of events from
e-core(atom), even though they have been disabled in the bios.

I wonder if there is a switch to get around this? For example to
override the list of events. Or if it has to be fixed somewhere in the
code, which file should I look at? I am happy to work on a patch.

Yuzhong Huang
University of Southern California
