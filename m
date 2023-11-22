Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+4FL2KR"
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5711D40
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Nov 2023 00:06:20 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc5fa0e4d5so54526555ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Nov 2023 00:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700640380; x=1701245180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c1dCVuj7iyX5Mc26hZdNFyVGTD/WJQ75bFBAJEJnDH4=;
        b=a+4FL2KRF0TcRpmEOpmPerouPOpfjEeeHAK13eSPGGsiDUGB3U9F7agwq9dmN+L6d8
         hQ618Io3abJDd6a5r95U8ncGBZRPp5O+YAOCDRTXjvCV/GFS8RkKhxRhTgVJIzUA1vZY
         t5ze1ZvifH1h0c4d6JDIRoZMGGd+rHq+W+TcgEBm8kg+Fepe5a83VWHf4uGqHGJQwuz9
         ozSNDowc78f/IkuOQKT0ew5TAxYPbNW/i3vxo1Ea2R+aepVPK+RBkYjcgEYpkUz5vQTF
         pHmrr2MUuj3X7bC2sWDzEg0q5qLZXnIyXGqLPWOdh6jK+vsVBm+TApmIhXb29+4PjzJ4
         HEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700640380; x=1701245180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1dCVuj7iyX5Mc26hZdNFyVGTD/WJQ75bFBAJEJnDH4=;
        b=mR9QFPoO7c7XaZJNDvYGniK6NPL5itvMUsjA/MxLuldN8pof0BiR6AZZrWh97iSJCW
         BOZi1N4qLp5SSwGPrLBo1PueOb7oNgNV/5Tmi9Gaf7RlHZI8Rzoym3b3diFS1nbVn1Tt
         kTqKJR7NCa4tDaZifbb9e3FiP7WdyHei+8jQdeP6dBoq4RLypufklQ3YFpAF4OOTQtmG
         84RHtosCsv9Tqe6rYpfA+MjtqaO1BbTu7exnj2jwax4YfkVrN97aY3xchUNTKCWWgBkO
         3VcsHrGm8qEp5mxdCzmdCNMdMbZVc3bT75XojMg5cUwUcH9lqRRPbsFC2+uSs6oYNINq
         L6Gw==
X-Gm-Message-State: AOJu0Yzcc0NQ3E7PPRVDx3opBl6t8wuQMQRfz0Y+oR3kTENRtAzzIB8o
	BlGkv+pgM1ONWXhyUFDzl4Y=
X-Google-Smtp-Source: AGHT+IGPBJQ4RvyCYxi1USeud82qzZ5GGj2CLL3IrPUWuAHhAcz92HmdFcFeENVci0ZhFbv/lHJN0w==
X-Received: by 2002:a17:902:c408:b0:1cf:7911:4619 with SMTP id k8-20020a170902c40800b001cf79114619mr1625600plk.49.1700640380118;
        Wed, 22 Nov 2023 00:06:20 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902cec800b001bbd1562e75sm9200377plg.55.2023.11.22.00.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 00:06:19 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 6B40F104A6A66; Wed, 22 Nov 2023 15:06:17 +0700 (WIB)
Date: Wed, 22 Nov 2023 15:06:17 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Thomas Richter <tmricht@linux.ibm.com>,
	Linux perf Users <linux-perf-users@vger.kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Linux Regressions <regressions@lists.linux.dev>
Subject: Re: REGRESSION linux-next since Nov 16th, perf tool broken (at least
 on s390)
Message-ID: <ZV22eWivHWOkKxGB@archie.me>
References: <aca1eb79-5dee-4634-8727-eebb251c9e1e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kD/iOrPCMbthXA+8"
Content-Disposition: inline
In-Reply-To: <aca1eb79-5dee-4634-8727-eebb251c9e1e@linux.ibm.com>


--kD/iOrPCMbthXA+8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 08:38:28AM +0100, Thomas Richter wrote:
> perf tool fails on linux-next since Nov 16th on s390 when invoking perf on
> any PMU event, as in
>=20
>   # perf stat -e cycles -- true
>=20
>    Performance counter stats for 'true':
>=20
>      <not supported>      cycles                                         =
                     =20
>=20
>        0.000598399 seconds time elapsed
>=20
>        0.000055000 seconds user
>        0.000567000 seconds sys
>=20
>   # perf stat -e pai_ext/NNPA_ALL/ -C0 -- true
>   event syntax error: 'pai_ext/NNPA_ALL/'
>                        \___ Bad event or PMU
>=20
>   Unable to find PMU or event on a PMU of 'pai_ext'
>=20
>   Initial error:
>   event syntax error: 'pai_ext/NNPA_ALL/'
>                        \___ Cannot find PMU `pai_ext'. Missing kernel sup=
port?
>   #
>=20
> This error is caused by following commit, which got into linux-next aroun=
d November 15th:
>=20
> commit 652ffc2104ec1f69dd4a46313888c33527145ccf
> Author: Greg KH <gregkh@linuxfoundation.org>
> Date:   Mon Jun 12 15:09:09 2023 +0200
>=20
>     perf/core: Fix narrow startup race when creating the perf nr_addr_fil=
ters sysfs file
>=20
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>     Link: https://lkml.kernel.org/r/2023061204-decal-flyable-6090@gregkh
>=20
> This commit adds function pmu_dev_is_visible() as the PMU bus function
> to make sysfs attribute files visible.
> On a failing system these sysfs attribute files are exported:
>=20
> #  ll /sys/devices/pai_ext/
> drwxr-xr-x. 2 root root    0 Nov 21 14:59 events
> drwxr-xr-x. 2 root root    0 Nov 21 14:59 format
> lrwxrwxrwx. 1 root root    0 Nov 21 14:43 subsystem -> ../../bus/event_so=
urce
> -rw-r--r--. 1 root root 4096 Nov 21 14:43 uevent
> #
>=20
> These is no file named 'type'. Other files are also missing.
> Therefore the perf tool can not access any PMU event defined by this PMU.
>=20
> On a system with proper export of all PMU sysfs attributes (same linux-ne=
xt kernel):
> #  ll /sys/devices/pai_crypto/
> total 0
> drwxr-xr-x. 2 root root    0 Nov 21 14:44 events
> drwxr-xr-x. 2 root root    0 Nov 21 14:44 format
> -r--r--r--. 1 root root 4096 Nov 21 14:44 nr_addr_filters
> -rw-r--r--. 1 root root 4096 Nov 21 14:44 perf_event_mux_interval_ms
> lrwxrwxrwx. 1 root root    0 Nov 21 14:43 subsystem -> ../../bus/event_so=
urce
> -r--r--r--. 1 root root 4096 Nov 21 14:44 type
> -rw-r--r--. 1 root root 4096 Nov 21 14:44 uevent
> # cat /sys/devices/pai_crypto/type
> 12
> #
>=20
> Also on such a system the perf stat works again:
> # perf stat -e pai_crypto/CRYPTO_ALL/ -C0 -- true
>=20
>  Performance counter stats for 'CPU(s) 0':
>=20
>                  0      pai_crypto/CRYPTO_ALL/
>=20
>        0.000741258 seconds time elapsed
>=20
> #
>=20
> On s390 there is no need to export sysfs file 'nr_addr_filters', but sett=
ing
> this member pmu::nr_addr_filters to a non-zero value before
> calling perf_pmu_register() exhibits the old behavior again.
>=20
> In my opinion this breaks previous behavior.
>=20

Thanks for the regression report. I'm adding it to regzbot:

#regzbot ^introduced: 652ffc2104ec1f
#regzbot title: event syntax error due to narrow startup race fix

--=20
An old man doll... just what I always wanted! - Clara

--kD/iOrPCMbthXA+8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZV22dQAKCRD2uYlJVVFO
o5jFAP0Wr5myCJsMi3WGhPOgpzrcrltN5fZQoazlmMqnPqb0dgEAt1O2F71h95k3
eUOOkchMZ09zYTnQyV+ZJTMvEEJu8gQ=
=jwSZ
-----END PGP SIGNATURE-----

--kD/iOrPCMbthXA+8--
