Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795525526;
	b=DiKUj4h+2VpLJiqZ+yK7/1YUq5rnv4PKzN5gwUwdkMMS9gziehJurgYcWSyIArWHT4OV
	 4cbnfluP31Vu+c4guyG5Bwp99x8wPi1FtVT59MavF0F9Y3WC3gScMBjC+MDmzu1bHeQNQ
	 5bBxst6bZfUxakMSUxL13x4BJ9ybQDHYyY1nHW9tpmR5lNBiw0gB+SnmD5dTf0Y9rmIVM
	 3l23VEQrt3R1jwQdV8HK05ty8JReW4hRDfQlPcSWc/SEfpR3D1sXN4gmHFXrar2vsI/mu
	 afqfmbt65Ng+TpvqxtwTYL899lVJAgwhC6r+XwlotmrjPLBkB8JvtYcvPaPREmcv24Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795525526;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type;
	bh=1fSkvm5OP0PEIuFbARo1EL9pn1CvUDlyi1JdnlX4EPM=;
	b=tFDg9HjaRbbwlIpzWOuNB0KhWnedo8h0fSMYWBbv5DwAlpvt4pgXWG4fsrFm+UUcwLoh
	 xfQe92rxmluKV1S5Ye31LTna6ZrQydS0p4hiScUzfthDdIg38fCP9nhOPdnWlZgTKVUCo
	 VNypCUts/Nte0zcZsGlwPbktiTUnPYNUsmQxtf8IwHZkY8d3d1u39f4g5r/83/vzo5RW0
	 VZsRyCmxY6PFa1kSJ7i2Le2jUECjWWctcnZs2FWhv8qfObrG6pR0D8lffsCn5fUWVjv/1
	 15nLUtn6Z37kPpAVqJMqtOMAWhpFsAt+1UtloYVByEESfQhe+8HOI25Rl0tsV2PDMDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Q5I09lLB;
	arc=none smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF701606A327
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 13:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF701606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Q5I09lLB
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6ba38c41804so5115981a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 05:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795525524; x=1796130324; darn=vger.kernel.org;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1fSkvm5OP0PEIuFbARo1EL9pn1CvUDlyi1JdnlX4EPM=;
        b=Q5I09lLByp8GrAga+z61+5M+gvAlJ4pVvlpe2jvfzdMI2JQJMoATfFS5LS9ZPidGNG
         jvWAweA+jd8KhbSMzj8JNgWmrPoQ5lrScSGaamKRZp2hJQCxvHllSSzIfxwEsbWPVFXU
         lmdK2+4F6qqkNeLXGkpDfOmSbd4o5l5NC2wcTUepdRIAry9l+Jx1W7DtlRdDsFcSG20I
         pU/Q0/zdgU1SWjHx38yKkYYDu1dKBwlnJjXRgbPkOvFy9W13kzHN9N3zrAUpbCkJi0oX
         ivNHAKp2pnuBYc11PL+TcwnZiPE4MJ3KJxnnf11wUXRLGKg3/O7crwPnWEW6JTakoUTj
         1MTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795525524; x=1796130324;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1fSkvm5OP0PEIuFbARo1EL9pn1CvUDlyi1JdnlX4EPM=;
        b=Dx5OWvzaQTWuuy33TRoFLvfno7lqFh5SiFsO/S+5l4TcKjG2S/Kxqz5CjGSqQg+B16
         SLZzQYq6vlcG1wWvH4Whhqn0DL+Y1cjVMAzcheAxSNcBn2m81IfTjZVXtxSm3rpUMjnA
         UcHkZTnSw7nJ6k5UIMhOROMza/ZHjS/a7rSaVsmrb+Sit2qBiq0sjMQxsdLRLurP3VGW
         rExaMRbztjL4MiGlQ3i3+ZxbNO9WBdPlRQuS/OAjH6UkFYKsOpr8zb6DIzwGYuyMWCpW
         wsIPwWVd4hzljjllp6zlUbyYgF7zdsp6yotLovi8DcSnri+RXDes2HrhOugj7vBO4aj8
         C8ew==
X-Forwarded-Encrypted: i=1; AL+hErEVCouDWRZ3X8rWciBfLdfur1GPQAIMNI5wRlY8KZGsYpEf4ptOQndaHIOLbBzLjG1fKZMG4FgGMszV1be9n2dx@vger.kernel.org
X-Gm-Message-State: APuU4Z97dsIzarjubncChvkHZfNWwWPtCGJbL4wkatNcyiA8oa4asXhB
	YNvzu5oUzrE1Q1usOz2h4xvEz3KAMxy8qHem8+kskxQUXqUp4AZB8b9ti7gJMuYO7yM=
X-Gm-Gg: AZFdTZfAmkXs63kdxNUgy0Jb+TqIz89FJug1lBqXcQgOSuHQuhjMji9Qc3CB/tlM8c2
	143y+ARXfOLK5aHktZmhfPwPh0nwOvSFRC+lRKawUfHb5v0bi6+ruR56i9LfXWOLP1OJya6mJMz
	laHLT7mfSe8JQB2CpPjWTN9Z9yLJp9Ulp8Kl93kOudYLl13lXRSlBF087CTQ0C9RRB++xlOjzsF
	8yl79f5XQCkrYIFNaaEzK0RpXdgw6OvBhKJVftiEaJALHUcqBLLCT9G+YgDNZS0VFFQZ4C9gnMk
	Zk5aRPFojz2MtzFvKalwGVYfPXPD8N1KnPYHcwW5ODTbTYH1dJ/GVGLnUH1Z8vwpgwBlMULnINg
	rmdY8fziTUJViCRz9uI3w9dHYyQaJIox0UK+clvjzT9bsscsW72GLztpucfkR4VzeZPFcEbzuNw
	Mci2su7eL2TIXPpKGG7rXOFwbWtOefE2PI6ah0ufFB9pZ7ZekjYr0P2ezFk76WGr5En3hRXd/CF
	H1oIK8kreqlGpUgcC8cHDerHdMYf2bT/0CcBwyBpXlHJQthLgdP8c3rMtHFFvUNFTaoluWgvGQn
	NoIUK/SFrp8Qr9MRhXPQe75bBrl3DpxETeWjAocFym0fMFzAoDdMWZdlDQxVq+EQP2PHv3HlQ/i
	BrjiHuOlx2MS74eNw8W+ZJhhjGkTtQBWeLJzLvsHmqx+XmweToEE=
X-Received: by 2002:a05:6402:3645:b0:6ba:c85e:c0e0 with SMTP id 4fb4d7f45d1cf-6bac85ec268mr3910962a12.28.1795525524131;
        Tue, 24 Nov 2026 05:05:24 -0800 (PST)
Received: from ?IPV6:2a00:12d0:afa3:c01:92cc:e257:77ba:97a1? (2a00-12d0-afa3-c01-92cc-e257-77ba-97a1.ip.tng.de. [2a00:12d0:afa3:c01:92cc:e257:77ba:97a1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370cbb80sm6784029a12.9.2026.11.24.05.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 05:05:23 -0800 (PST)
Message-ID: <59d4ee28-0605-4e93-8ac1-19c8d0272bee@suse.com>
Date: Tue, 24 Nov 2026 14:05:22 +0100
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] msr: replace rdmsr()/wrmsr() in comments
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-hwmon@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Guenter Roeck <linux@roeck-us.net>,
 Tony Luck <tony.luck@intel.com>, Ashok Raj <ashok.raj.linux@gmail.com>,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20261124064108.2440277-1-jgross@suse.com>
 <awWHd9ygPFipisb3@gmail.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <awWHd9ygPFipisb3@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------fzIBNZKANk2e40IQjwqLyzcB"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------fzIBNZKANk2e40IQjwqLyzcB
Content-Type: multipart/mixed; boundary="------------eO6WT9kL6g4GOfnRabTN4O78";
 protected-headers="v1"; hp="clear"
Message-ID: <59d4ee28-0605-4e93-8ac1-19c8d0272bee@suse.com>
Date: Tue, 24 Nov 2026 14:05:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] msr: replace rdmsr()/wrmsr() in comments
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-hwmon@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Guenter Roeck <linux@roeck-us.net>,
 Tony Luck <tony.luck@intel.com>, Ashok Raj <ashok.raj.linux@gmail.com>,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20261124064108.2440277-1-jgross@suse.com>
 <awWHd9ygPFipisb3@gmail.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <awWHd9ygPFipisb3@gmail.com>

--------------eO6WT9kL6g4GOfnRabTN4O78
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjQuMTEuMjYgMTM6NDcsIEluZ28gTW9sbmFyIHdyb3RlOg0KPiANCj4gKiBKdWVyZ2Vu
IEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+IHdyb3RlOg0KPiANCj4+IFJlcGxhY2UgYWxsIG1l
bnRpb25pbmcgb2YgcmRtc3IoKSBhbmQgd3Jtc3IoKSBpbiBjb21tZW50cyB3aXRoDQo+PiBy
ZG1zcnEoKSBhbmQgd3Jtc3JxKCksIGFzIHRoZSBmb3JtZXIgZnVuY3Rpb25zIGFyZSBubyBs
b25nZXINCj4+IGV4aXN0aW5nLg0KPj4NCj4+IEluIGRyaXZlcnMvaHdtb24vY29yZXRlbXAu
YyBkcm9wIG1lbnRpb25pbmcgcmRtc3Ivd3Jtc3IsIGFzIHRoZQ0KPj4gY29tbWVudCB3YXMg
aW5jb3JyZWN0IGluIHRoaXMgcmVnYXJkLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEp1ZXJn
ZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCj4+IC0tLQ0KPj4gVG8gYmUgYXBwbGllZCBv
biB0b3Agb2YgY3VycmVudCBjb3JlL21zciBicmFuY2ggb2YgdGhlIHRpcCB0cmVlLg0KPj4g
VjI6DQo+PiAtIGRyb3AgY29tbWVudCBpbiBkcml2ZXJzL2h3bW9uL2NvcmV0ZW1wLmMgKEFz
YWYgTnVyaSBCZXJ0aXpsaW9nbHUpDQo+PiAtLS0NCj4+ICAgRG9jdW1lbnRhdGlvbi9hcmNo
L3g4Ni9taWNyb2NvZGUucnN0ICB8IDIgKy0NCj4+ICAgYXJjaC94ODYvZXZlbnRzL2FtZC9p
YnMuYyAgICAgICAgICAgICB8IDIgKy0NCj4+ICAgYXJjaC94ODYvZXZlbnRzL2ludGVsL2Nv
cmUuYyAgICAgICAgICB8IDIgKy0NCj4+ICAgYXJjaC94ODYvZXZlbnRzL2ludGVsL2xici5j
ICAgICAgICAgICB8IDYgKysrLS0tDQo+PiAgIGFyY2gveDg2L2luY2x1ZGUvYXNtL3NoYXJl
ZC9tc3IuaCAgICAgfCAyICstDQo+PiAgIGFyY2gveDg2L2tlcm5lbC9jcHUvZmVhdF9jdGwu
YyAgICAgICAgfCAyICstDQo+PiAgIGRyaXZlcnMvaHdtb24vY29yZXRlbXAuYyAgICAgICAg
ICAgICAgfCAzICstLQ0KPj4gICBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9pZnMvbG9h
ZC5jIHwgNSArKystLQ0KPj4gICA4IGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyks
IDEyIGRlbGV0aW9ucygtKQ0KPiANCj4gWWVhaCwgc28gSSd2ZSBhbHJlYWR5IGFwcGxpZWQg
LXYxIHdpdGhvdXQgdGhlIGNvcmV0ZW1wLmMgYml0cywNCj4gaWUuIGp1c3QgdGhlIG1lY2hh
bmljYWwgcmVuYW1lcy4NCj4gDQo+IE1pbmQgc2VuZGluZyB0aGUgY29yZXRlbXAuYyBwYXJ0
IGFzIGEgc3RhbmRhbG9uZSBwYXRjaCwgd2l0aA0KPiBBc2FmIE51cmkgQmVydGl6bGlvxJ9s
dSdzIChwcmVzdW1lZCkgQWNrZWQtYnk/DQo+IA0KDQpJJ2xsIGp1c3QgZ28gd2l0aCBoaXMg
IlN1Z2dlc3RlZC1ieToiDQoNCg0KSnVlcmdlbg0KDQo=

--------------eO6WT9kL6g4GOfnRabTN4O78--

--------------fzIBNZKANk2e40IQjwqLyzcB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmsFi5MFAwAAAAAACgkQsN6d1ii/Ey/z
ZAgAisD+DZAdNXgjnVdM3s2bM/G2CpMIMc5aSo46KHC0SSFWxqgAn0uhLwg6oV0HfEM4WXejTWZ4
EPP6mOPAZTe1Y4she3H0RVq9qe7OAi2Rn3YM5XbKYmsxBf1dLD+xOmgZtSrVKA53/tvzcF6CriaX
w/KdLsxB0ASxzQIvaBez16RFmGVZ+veCA7XSqlfjCSvT7Ir6NTNPfbt/MixiHLfp+RMEBYG+gHzg
SSvjqAx7UG7fvGOt1cA1zW8ETewsqo+MpGIDVocuH5M5pF/kk0470EkP7An2N/FRvf296caLYPpy
LI550rDXjx1h/XL2gRPjKEKSJ4WJ4qz032FTkhwbDA==
=wTmJ
-----END PGP SIGNATURE-----

--------------fzIBNZKANk2e40IQjwqLyzcB--
