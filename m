Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEC6189B84;
	Sun, 16 Aug 2026 08:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786868846; cv=none; b=MZjYr8dKUwPXSt3V7PAne5RbOhplBx7rMO0vq4L3jb7sXx5tnWK+xgO2pB9pDwti2M5YXEuH9R+0T+y15yZ580ACUxFcLgV2+AkBAhP12KuQyGQuLlJNT6PfBfKrCVLgI6RjQiIWWBOjU71XA6W6MIyypjHwa6OKmCbrtIVwR24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786868846; c=relaxed/simple;
	bh=9+vPTjH1obZclMWELJOWZqt0EDF9+G4mhLL+jRsCQSs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=X2dsxSzUnr9r6pxc+TlfbevNQrCAYe+PtpQEfNd0zx4Jcg4eZtet+jqmSbi/+puNRg7/QB0Cx2QIjNmzFs3R7nhdlcyFg9GpSR9ww/YvgZKOgIK3DrKQOmRvJu/dD/Ip0jYLjWXxtk8vJySfj2kXba+r18GdiO7FZhT2C4UUQpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=PRCYFGJR; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="PRCYFGJR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1786868815; x=1787473615; i=markus.elfring@web.de;
	bh=9+vPTjH1obZclMWELJOWZqt0EDF9+G4mhLL+jRsCQSs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PRCYFGJR6o3y9Zr1Le9tU0IwBcpNPter7jgcS0ApF+N3vV++v/uOeJUno6axuutp
	 zxikOGlY83t1iC+d09p2iAMwbI1mJORvoruf7tQofQZiv49JDYll/btkySUCd9fZk
	 pUAa2bhv8w/Lbv7E3kmKeOQjAohaSwPw0XskVB1/+GM5VSnIFemrwew/7Rpg1HCQQ
	 sKqm4v7U2979huqGf8zWiIpMZ9CduHM07GFLW8h/LRnS7T3N3+38mp/kV0ZJJ7a8r
	 +ISXPUOrFyCKvQvnOSM8wQk08j7s8ZqazRKaLCqNxLHm1asedbkYu/3yrei339siS
	 fMIuhg9Q7h89KROnxQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MMY1D-1xEQES1E8d-00XDVO; Sun, 16
 Aug 2026 10:26:55 +0200
Message-ID: <0abb2aab-4752-478d-bb53-c5a84fd6ba2d@web.de>
Date: Sun, 16 Aug 2026 10:26:39 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ruoyu Wang <ruoyuw560@gmail.com>, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jing Zhang
 <renyu.zj@linux.alibaba.com>, Mark Rutland <mark.rutland@arm.com>,
 Shuai Xue <xueshuai@linux.alibaba.com>, Will Deacon <will@kernel.org>,
 Yunhui Cui <cuiyunhui@bytedance.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20260814133925.1385687-1-ruoyuw560@gmail.com>
Subject: Re: [PATCH] perf/dwc_pcie: Fix PCI device reference leak in probe
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260814133925.1385687-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AN9KRgw7WBdzhd4V1Yts84ypyr8SzdQBkP8+Zmg8KKnfhYg7NUx
 oVRyV55S/wXlRRvgzDkR9HnBKgU04+7rd7K66rH4fb0BThRIS3u3EEsvHIPpMafzK97X42s
 4+Hb+quNAI7Tva/MiQV1jBn+1i7Q6TgvxD4oy07TVwriGxLtWCkdZQz54fA6CKOJociv/dr
 u80CJgi5i+bEBsB8SFPnQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:41aGIEboJ+4=;rM22lVxXhlCCUJrairY+GoBsWpe
 ez/mvVWAFkD0BB2Ban0FkXFgfpcOYc2yJ3E0jhoenD0RlUzLoMyT4JuQ+qw8zz1OFFBWXHCLK
 P1qr8yQUizw6jpnEzSmN4u2YUC+mPwBB0BiPKXn4T2so7j29rrnCv1lttfBI0jR+af/LqnMBK
 8NPeVzt7KqRCJlZh7Q/1IAxgBA47lUe7QY55yYm8JMRXtpBS2zGYCGrPiRGluRd+Q3heJVF/X
 agXwTfShB/kS/3de3DCrUjlSgzrEUCJSD/z8sgkPjkroPbTbeDhMngyWVVpjWyGAASgiCcAgm
 Gv1mQ3jZln8cWiL0tR26N2CGg7T9DDhxKQncdC/3cr+Kjeru9StMDIQfG2jOqdR60FT95HzuZ
 3IKm+2nfAjvedg2IAP08wA0jo7tR0qJH9qvU/LS7Y+aahYiJ7r5gSVVZP1FvjDSyXLdFBKF1n
 etiDxqlIFBQAvrkjkdNSGOrh6CEi0yPEkQpMApYCcNRCwPyfs8u0XmRoOw6DkJThTgHPmoFNb
 4YdXC2/Z5k2mTrKYJ0hPxk1XLX0pdgabyHvV7lhANdWnEOc+eY6QGqyq8iAm3ZX3BPgY8Yoas
 qkKz573ODm6qv7uCSfZMkhEx1XPl/rqFQEaLIHxmO8JNzc8AYE9mTfyuMiPf3a77PsShPcrcd
 mNT3zKE6hvsUnm8K4LUXyp+V93gXhNGLKDnFifok84TzMP5Tui0dmLmY5ui2nfmznhJ9cV32N
 Ji3eM0JqmRuINiV17xZa+OHShURcGrtjAgxvRomttfARdBnMOSbtF7cTWfAkucs6CXGQt728s
 EqNqgGtUUk0kE6hOMsk0tV7jJp+fa/wcEAejs/qkIdy1JGSzVEaa7p4jjLwBMa6aKZe19Kb9x
 zZ3PDdR4hndfKMtWxcg2e39GXG7ZWO660b2YC1M6gx9GavMRGYnLL/HygBE/xnk0vp77CaR8F
 7kp0Ccc1Qth0hCcSMNzBzIv9O80zzda5neIfWxRwKwN4enaJGEv9dILnhEM8wWaOG+Y6tXLg/
 eE0ufNnWOw0/Ltdqw3PlCGBYyeYt71oAoi5CcweL6nPPDR2eAJ+K/i3gHDICYCNSbyypJC7K3
 5j4O/XcI11M7yIY1OcaVEn9lkfMCWwdJqBOylr5J0OTMWEbMWyWNqPxqZOAPiXf5pDxxXg5yL
 yewT2L5k4viE5yG76BDcK7ixaV8UAqjX+LG540hk9HeUwCqxBlro1fn1zQ63UT0CvW9bj0vFL
 r5sniCM2guX5El47EoWZL4F55llKIIMBz/Pb/dUigv8DvQb9mw8g2EO9vf06GnLTQnwMIY60F
 c7jWeLEXx/q0bk1BewISluDu/14NlQbk1K5TocTI35hCiQ2NW6ZvXhlOyjBQ27uGcgb24kiMX
 /6aDt1/fRVDNb6BOXxPHUDIwEIb75wnHR9m9dzG8iC41HrNRQDAvAH8/4ssZZq45uBfpYHqKX
 GPCBT2Pq1jqLtnmXaGR5Is2LKQD94zZiRMGBD05XUtuMwFoFekkMdiVypecjs1ZxA2t7Fq7o1
 HIKncQdrZHpVz/bKScqbfsSWOS+zrxPAo4pQA2tlQiKS8dDPGHm8LP0GRhOdFk6MaPvkFxtQB
 PtWoaN3xeI91lboM3zjBF1ozPOHe+F9aa/NElb94msiOXUt/l7+pIpuaqueAu66dsGPIZRUxe
 U6UP9rf7ar/rb6tQ300gCIyBuAmmMwuvyKQJdim+J+TgIibZF/kJP+IpjOEYJkUMYpuVKyvd+
 jiizE4pbdD00/6lIrvt7feQlqTSN8NakObqpCAu0WeVPKj2HOV/4kRGJ7dgzxH4WZtmlqFrEI
 gUBrS1rn5q6qmp+4OCTmoJwQFcWDiDZZjP5knmF7CdnUpfjBvxKrXahWm117PYrBdT7DPYa71
 q4fCtjD6jM1rccsQ3rjHOS223MidnKLGTymEjenlWJdi5fx2H2l+A34qN5fYeeQoNp6lGvGue
 E8vE1NHVVdA/g5zT+mUpWS8EQMEOMv3MNAmZArO2evd8Q4m6b0Vh88gUtpq4+6ACo3x3WW0am
 W6ewENtqbRHED8KNOAP9rp8fkCeSn+ppdoV1K121wJuuF2kspQ/F6xP7+zQtZGezoWowHBJFw
 T8N5w1EW3vaLbrBVn328EfJBpnCLqT5kxqxOQpUo/Li7aMYNLttl8MxOy98PSh1K3rEjulBl9
 sxFnsR2mpC7sLu5lsDOWz3z0NaSpLiJ5Aupu3sT9XfJtA7EJaya8sMcP2Ri3zbG7n+299XgWG
 V+gDfgtLFXS4EPXcpgZjz6iKAB/+Ha/FXayIFdzMoM7BNaf8pDD6AZ5THGIG+x6LtQEbu2vV9
 tMJ97n2bLkOtiHionaq/P2f6WWPd7oOko26Q7v2Aecda7raGBfI0Gn8fD1U4WFkMja9euzIfh
 uWoFuTMQhf/BihhgJ8wuMDzysiArfkWxPLP/TcIPv9qdFST9W0LhheWVlCFFynKOx0F2U4zr0
 ksJ9cqZ35qj1ScvvLzPK+bKK2PX5bhMmtlVL67ThAhAGp52K2cLdq8gKW7wW7yQS8i6y8z8mq
 rcHZ4gzeyi8XmIDUODwm22GyWTXwB1komuUsNK/4/kZCIlq/qUVeqGj75+ivy5xIkUI4K5IU0
 TXRD8AjJCcTsT7IQcKg0Gfnnsf3eWR2XJ3ZnBXCfsLIOjn/dzxICqssZIsmQqsdfQC5ni6rr9
 BWEvmJAaTtlzNgLzjeT90zpaa1WgVYt/NtDCx6vmS1uWSPi4+2qmo761W36SwybagYH+Pp0CS
 D20c8esitqlG8jFKQrRpB5Xrx2b8vMg/nlKB/vvEjwzyMYcYgaeeGDF/fui9aoYiCZVk/KlR3
 CvKyLlMtobNaHiDt2wJB/CbE5Ton5cC7vdZT7nU6CgOzfxCahKOtl0dj5968KGO5C9gv61MTM
 1lkWF5HHBtz+gKCWEfEIpbES/zyvg7h5iPVc4EataaXTxQpS65w0/0035MpnOx+pLZgfdUoC+
 RC7nNpEqQLqLdpHHCzqvqSNuw65P8/LoTkGNLZ0TEt1L/SGALw9RASA0Xu4UT7f86uz6DRlDv
 jRpDvSLkMoKBLKXPVSENbaGETY1R0tTNH2WYj8G49y3G+VfRHjv0FXy5h3t5chHj9Ib4uAZ/j
 KMW06RbrqeeWvuSCR22jf4psJu/6mXIrUL/rRgOzDHROS3QoVI8iXL1PwAe2uFtpSweuu0EEz
 sT+/8J4NpMfkwwKAObCjEo/3BMg9R5p8y53+Nzspqv0P4GdaY5kG2g0CpWuvvhNPGQijvolsF
 5A4QzP6XrlWmmLT9bEFnWZfIhRC0Tz3BQ/aWyXcdts6z1HgIOIkAjk1i8MnE8yYU4R3CybAqm
 YT3dVfKAMAwpsaivytF7sO2RiQwSxbc9Lss60xhGZS4wlOqvROKBaIqBzDn+DxpgqeG+VzVCI
 4XX/NGo+yxOSwkTAkU62MxdHvJw1JfpSCmoL1g6vtHSxgTo+Ax2PA2FhyG21Xsji8sKETtp0u
 1QmX0nAploeJBN+PG1UfFZBnHdRLke2YfEhxauEvk3eqs1zZB5bdS9GSPAhs1d8GYrKe54tDJ
 jlS5ot32gBQXMuReQsvMwj6BwAW5+oFnF6/rUKGVuFDRa3fLZeTJEdTLWEhuQ3WoXFjWzi9fy
 abD5mwkYh7w9x0x24fOWCcwJyipMrqLDO/J26GJvKgDPeR/NubpAYmFh2PzcVADJEvhtQsRMb
 bKHU3Z2zUsHsLZPRuinhHAM0Qgm5koN5R9x0OsDyNJkKyfgYv3wjb1TDu+XykogrUSs3STxQE
 ZuaioJ2pYE/35+QPHrlHEFo0+2tq53Igblm6mZs3WE6lNhRBojNdDsH5Nyh1pY+ovnpxHYL98
 I3iTBJG/1sBRxHgHvkoD2/2jv7aKTTgJdW+iEyiDXza8UVp7ns50JIfnKt2t5ntasUER8mV6i
 0FbTN/+qjpYB579F7A96ywTwv1uoP9ze1wXqjb83uJLeVqz8jD3YKELFsI5PnFlQYSILDISKP
 DSlNQp4dyFB8wp6jA1nS2EEqBfff/lPEa77zgjK4e0o3Z1I68cfHx6mcOlr59wtNHLzn4BFQz
 lPlngBhjkzXHHmQGAAB9VDhDghGKmAv5i2xh9kO9kSsjqdp3FIGgG5o9NlF89q8pdf2vAgSkp
 hyetAs3Lwi6Hy1hczL9LuHjWRLzlUdZ9KbjHwcrtO5+oUUQLNpbd0seYmc+TUexotLxLyRkbZ
 KPyAn7oREhgzPuScwN4egq2pp1GiZzuJl59HlBz7NyM5ALieSMeDgaQ93uiXDH93gRql+r6lb
 RAw9NE73OKH983OLv7kbAWE48Yxg0rvimXlIheaXEyKX0wt1PW3vDP33GiXTtYZwDpc4W9y+q
 e61TDInPlpUUmX6iKOCEc5U+QLqSniABkbgzBaGHT/m2KkHQGe2TaXEauNo28om0Aan/WVhFv
 HscKo5zazRs+5B1IFzIUPxRKP7ft+uuoMcFn+9t4zgRWq/Mxdjo7iKPr4sPtjp+SXUwijuV66
 Maa3lE0sofNDA881pJX9M+Hwrj+vSdssd9hPphc/8BxrIIw0Kkku7b3hfk73ga+8wpidVzqPl
 wRLDTuY0CX5CsRA1q7vvTLG/N7eLRmiHYxmjSb8+yAh7doHuwhdzRhiI/agGCcka7I/djmA8b
 mm6XkZCbB6reYWb6kn3ow3IJQE2nHsUEp/gOy3DTG+upckE/nQmzv1zL+tZYP/d+xTnJuA8aJ
 kYE3GVfMsdnx+rhfT7kyxYR/Sng2bP6kO21rXD/0GNqRtJ03Ad+/x6f0Z0FVYFizgYWznCpA+
 li5SbL+cub/xuieOhAfVn9KhqIkfB9QHmzGSimDFPJOjamv8c1DjbEW0lTKNQWVV5ytay7T8q
 O1TjES6tEeCXjC+CHX4JGMt5qD8cgkGFMkSRV/siUsusRP0xS2K/p0yCIbm2cT9pgAUzLI6bO
 cJsF/UpImiz+TWLEDycgbAsKzRlBbTuYU+l//AabdQEqYQelGiFhAm7wd3Hd0UGDlykhB4s+o
 dpSMWcYCzS6mHABiVeA4uCi7tPH3i4/WZ/K3gYr74Pg+J3+0bNaSPl4eBem/Puv5pU7OFi7Yk
 qFs8CofJsHQgU02BPMUJdmAHDIUNJS5dnl4ZT2rOVrGVklPAjv53n7M86+SDsktb2mEOyhkJX
 dKJMdT4dVNsK9sTNksWqUxMcBBMk4y9pl1btWAtsz5dZWb4irVYCfGLvSlgGTU1APWGe+H069
 t2QXOZ1L2Eko4Bdp3vm3zEh0iyaH6r5un9LZaGr1hGhRm0c7Gkb/rtHxdmj9rCjHjJVra0jhZ
 NODZkhawaf7oqOkW53ZMn26a5x89sVNqfc7KQaVmoqQPQ5XBF38F/gZqXupiomceSksur+fO7
 f8mbmLIyrZRRoSDTBr0a0PFyMIf4n3+Tyl6+5K/+NMEKjcSMDsVN8kqvhRurAxZChb2fv3EZf
 LQKt5ozZ3dlpIOd7sbhC/oGeQV7XWXmmUrfADt03B4q7O1CftomnDSm3wKd3wB0ECYOeSQhOs
 g8Xz0Tp4qJUya4dABG2fBxN7C7rsf/5EbxsABP/AiwfT/KgNU+HfTUIPpfLnqpL1b/3BG+pQ1
 hSA6sihtGmAmSGsaCZAYHXAXMhzSUkIZtuQFDv0aaWzN9oDXkdB9tCwrhC1Ek3/2vnPVrpJgl
 NSd2X0nVq8r/fjBQWFSVWykix+fb16wkhCFND2jiXOQR1ofOMXYaFm517t9RrPr3z14Jyib+s
 GvkxhxeMNmnb3FMrWuFyQKLqDhh1UgmUoQR7PDnvMEHkDMRZ9EnVEOK/EexcK2YtPlz1Kqie2
 UGmTp5KQqiK6LthWgEuPMwCNhD3QDrbJ/M/b5CkKiQZcjSdsW2fNeKD83EpCFWL2O6eBSMce7
 GrscgXGsO/UHYLyD40Irv+k6uJ72XwULuXw9JVJI6I9apogpU6G/BW3Pzn3k4ww9l+FwnwEKU
 qFFJ4uvI3P1p0fFgI1ch9SV+gLkM8Uy6mVK7NX/QNLF8ThdjjTP4LdpiH8YuSNnJG2+MGAQpp
 fpXc0H0XKIbW0AP4Eh30oFFfn6tKRkshhKZAH1XM4sZMYYdf/cw52vH/zrluehZs7jEBXn2qs
 U+O11Vw==

=E2=80=A6
> Move the existing pci_dev_put() immediately after capability discovery
> so the temporary lookup reference is released on both success and
> failure paths.
=E2=80=A6

How do you think about to apply the attribute =E2=80=9C__free(pci_dev_put)=
=E2=80=9D?
https://elixir.bootlin.com/linux/v7.2-rc7/source/include/linux/pci.h#L1269

Regards,
Markus
