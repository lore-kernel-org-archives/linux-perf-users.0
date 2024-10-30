Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120C03C14
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Oct 2024 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730250034; cv=none; b=rzgGnUNCqA4RZFF6Ob0zq/5KI64+cedLduchtbVwNbO2SpDyaqozMXCfxPdY6mFNgvm6cOBgpVJ5kCqUp4qhInJNumHb0NKQ1+F9OnzZ51Gz33IHevo2f6HKbBWqle+p3f+lSeb04PbTmHLdwJ0QxUIndaEiXc5r/IyzoopQIdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730250034; c=relaxed/simple;
	bh=WdczWybPbpozoqJA5jWjwYdjgCrp02DD6s8uF70s8K8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFpQWwtppnPsnTKEN80FN7wVAHmGPtNgevZsPxC43oGtu4L2d+DVVPTOVKDak/4BFPOHymYhil+ar9je02zVBj8w6gfBP29KZrzuaIEwFi7kT7jboAnlLnZ9KeqxUVi8QyuvKxHduRcIuTmDSkB5CN3sUMUnquzMpXBJddvsXWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHz4qjs6; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHz4qjs6"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e38ebcc0abso72121547b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 18:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730250032; x=1730854832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I26x9/0eWJ6uIX3kdOyzEqIlt8KVeV5dF7e+Q4qc1CQ=;
        b=KHz4qjs6lU/BZnnWhPWlBTXrXAvefJcDDvIgA6iwA3aqaUauvSS8x2WdF5RpXiTA+Z
         vCujMExgY9yJKAAxnVBp2uROI5XHSYg5CxaNiX8vydMjxhOwl76j+ZTlN/61T/kRyX3s
         hoNUQUeOWypG/dVM8xsz1/pkhg4pWBhvO/qs9p51i7IyHKiDw98XqTR4d7OR/cMIrKND
         MG3rutzh7p42xYJzuvpD9zZWMqNcL3eecq7GKjPd7AY7PP1DGRx3RfKqV+LXfr/ynlTE
         yr6UMRiFuGoia1p9UP+YkCdh6gauLZmHh33Om604jWoHUseLRHayaVTxns2EhSwdgXaT
         Mw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730250032; x=1730854832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I26x9/0eWJ6uIX3kdOyzEqIlt8KVeV5dF7e+Q4qc1CQ=;
        b=uNKz51lu9zCYeVaJU9Jkrq4jxIJ4nwcL+1DlY3MjM74/Mwh7FVvMRnoV7J42qEK3kk
         JHVl2SInG7pA1f1CWcD9IU8DifFPt5xjzZ53L4VE/J0OitAZoWUWiWY7uqjO/qeRKIT/
         YNCCgv4+eSS/QIsnDdkZgHYAnbBCs+vH24qzlX9yE7AISAmqkfEl5s9P4/uZZOeVEG0a
         tsYsiPj5iBpMMtKOXQieroSBTrAqE/uevJENqYAANLvW2MgkYwSl3Hl3eXkodAE54xc8
         an2Y87jvX1VWYOiiT3ScE4KFcq1xOzhc8WhHei/vPlnNbMyDbRzkKFAs+u1lvazBrgF0
         akrw==
X-Forwarded-Encrypted: i=1; AJvYcCWYOSWYjtr22b0kCtZyu72y5oqHIv5uH/buSH07SEiXcXRt9QOnDtNFUhK41G6HMhaWCWykexIkhP9lvgJhkxMg@vger.kernel.org
X-Gm-Message-State: AOJu0YwX6AaccpbQL/+6oBcAX/zDsA3waPyR0nRxdHznbvwe/CfoqmPL
	MSh0YKHZSQyNYZ/Tp+YWrAIM7mRrWACrsoQr8szZjX2jrwk+F4OHOeE/ZnWrYXq2r+5knIcMqo6
	zeAg5Br8bGwtetYTBRx90kV+OLvBtXg==
X-Google-Smtp-Source: AGHT+IHuVtOVQjHg8LrZUpNBpNJafxr1rHMGv6+EYhl7A+HX8dJgrFVdqTQKoa2+pfFEHHEUjBLwEqLETZO6dqsWMWQ=
X-Received: by 2002:a05:690c:6c08:b0:6e3:fd6:6ccb with SMTP id
 00721157ae682-6e9d8932b09mr151316217b3.13.1730250031804; Tue, 29 Oct 2024
 18:00:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALwKgup1UhiKMHvEni_3gaWoC0BLu8kkT6R=7R=b-LkBx5_3ZA@mail.gmail.com>
 <ZyF3k__jUtRUAcWm@google.com>
In-Reply-To: <ZyF3k__jUtRUAcWm@google.com>
From: laksono <laksono@gmail.com>
Date: Tue, 29 Oct 2024 20:00:20 -0500
Message-ID: <CALwKgupNAgc_jEinqsYmH_n-u_JsSOrjmY9k-33VAVrVVL3M=w@mail.gmail.com>
Subject: Re: Intel SPR: perf-record doesn't support topdown events?
To: Namhyung Kim <namhyung@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namhyung

On Tue, Oct 29, 2024 at 7:02=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> I guess you need the leader sampling with 'S' modifier.
>
>   $ perf record -e '{slots,topdown-be-bound}:S' ...
>
Unfortunately, it doesn't work for me:

$ perf record -e '{slots,topdown-be-bound}:S'  ...
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument)
for event (topdown-be-bound).
/bin/dmesg | grep -i perf may provide additional information.

Regards

Laksono
