From: Martin Ichilevici de Oliveira <martin.i.oliveira@gmail.com>
Subject: Interrupt caused by software events
Date: Tue, 8 Jul 2014 11:42:42 -0300
Message-ID: <20140708144242.GA300@gamayun>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yh0-f52.google.com ([209.85.213.52]:58941 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbaGHOmH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 8 Jul 2014 10:42:07 -0400
Received: by mail-yh0-f52.google.com with SMTP id a41so2355918yho.11
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Jul 2014 07:42:06 -0700 (PDT)
Received: from localhost ([201.81.88.138])
        by mx.google.com with ESMTPSA id y3sm71080404yhd.28.2014.07.08.07.42.04
        for <linux-perf-users@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jul 2014 07:42:05 -0700 (PDT)
Content-Disposition: inline
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I'm learning the perf_events programming interface and I'm not sure if
what I'm trying to do is possible. I could only find the perf_event_open
documentation, but unfortunately that's not enough for my needs, as it
only counts the number of events that happened.

I'm looking for a way to determine which instruction caused some events:
something similar to what perf annotate does, but in an online fashion.=20
Ideally, I'd like to have some kind of handler that gets called whenever
a perf event occurs. Is that even possible? If not, is there any way I=20
could get this information in a real-time way?

I'll be using PEBS or IBS events.

Thank you,
-Martin

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJTvANiAAoJEKAgcdgOx8KDtGIQAImXEh3MZzJL9Dr1u9rHCtHc
FbELhV3NYt9Yt1gTdjHnpUl+qnf5Q7R77T6FYkooCJHGixhA4I7i6OjEoxGbd3fR
YDb1PB8YaS0N7jerv/nB5wlgHIuIGpq+x+TdpYoZ4/hPfvBYTV2shJJfXH3Ln9Xe
tvdPcVgt9+hJeNLrNC9yfmi1LmHYx6MMC223T5ytl/1fUVAlhgbvXWTI8whVEHBk
DbqDOBpYKf5bpxZd/018WwMfnRtpEy+eHdsyZvp3VCk7nYRaVPCzoB3Epl2gqfLL
0JGLMcy/8MhLfp4iOGoldRomBNZBJpriieL1B0HzLOVDRNxLY5I57q9RQX7U+A3o
oBY25M64UIDk/hpU5Heoz+V7cVcfA/8C61GL6ODbFB/AxnMWt9+1EtqWlqlN7GMa
vft774CUVY+WfMy0H7yFKKwLYx9vNmcAp7vHhfHnP1AsfdUC1hdA987AQGVs2vJP
g3/6c372qEUHBYxzWE9+JOlaCRAUN3HSvZ12Uic9ewoJtcWt6QyqMpsDPFjVCtwr
7Iq/j2RLSwBGK7sKNpgJZts48yNt2WQg1ef7L5972U9t4qsXBAUrazbKV8OSYS5Y
tib4P+RGDl5HPcBIwREaxGFUaCRC/bZUYq2/OVnPw1C4GTq2aahlCUrJhy59V92m
BUEPl2dx2BRZlEkWYr3m
=uYq8
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
