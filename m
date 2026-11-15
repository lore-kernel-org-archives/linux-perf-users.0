Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794703713;
	b=D1OZRqUyEuZ25nP5ICs32K5SSd8EUGEADgdifTcjzdoJO4bAljexuzFbT993uCPHoe0H
	 xds76g9dnaZgxD5anNr0m2h0vI/3Y4MoV+xQf1aS5jwC3zsi/8cxb76kLLDqB3Bdlhr9g
	 AG38uHOMuZtkgGfm0m63vWqa/6uHHtSbHbONUhL1kOxSMKlpLa3UDEuATsEyxjb5iMVHk
	 6qU0jEH3HQc9vp8RFTkIMsh8J2vue5KiBO+ZqoNnLkMdi1EsDWCzV0/O9XtkBZht5us77
	 H3gUa/bhTgMOUB+M1W6MeU37ZlsgsQgy1WQDVoJV0wx/d70dBBcg7UzB4N8LO2ZTrQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794703713;
	h=Received:DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding;
	bh=zjUfvt4E6TqQmZLGts/lEUAcGTu4J+N1mffao8Sr4oI=;
	b=s6eJsOzFt0FTbcJZN7U0yAhFNb/NGTmgaB/S7XOGnFjIP7d1yyk5jflUww4ewNsxQ0yk
	 JZI/wNUVRWhT9L8gPKSNNKxHa4hh2LEuNKBx61ZYZ4YNntpJpuadcZqFXuX8yS06RVEzR
	 xJ6IyvgiMr70cxSqmeOG/17Pvf2d8m5mw8ZrEg1/uZYLDFw/b/KB82987nJV1S9/ZAHRJ
	 ziKF/ttYJVF/I8T3bsRZ8Tkk4jCrj2Cxl8Epk+1+E2aSpKYIMJMNkaffR4413olFHeUL+
	 FET1ZhhJ2kpUX4BjCJkudma1MrCP+LRDtb4LacTKL/UlqQIlStXEMIh5XpmBVJY3Tpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KmA/H7te";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E11606A881
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 00:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KmA/H7te
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490091F000C7
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 00:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794703713;
	bh=zjUfvt4E6TqQmZLGts/lEUAcGTu4J+N1mffao8Sr4oI=;
	h=Date:From:To:Subject;
	b=KmA/H7tej1qXcrDJgJN0BwTOMRjJczFBRp/UQ7FMe5p3j4DIimP/ffoNYrydzHeHD
	 eHB/VXJ7V09R/h1Dej8+r4aixvvgwWoPKHMkub9I8A8fCqG8zU+A8dfhNuvoYGULpK
	 qtjH2SgETci7zfjK4KjzBDMR8o5/hFjJH4uJx7pMuoyQNZYnSKKvQm+SxX1OdsQp58
	 p06GgXobOBKyX2QMWSliJrfsn0VUP/ugs3Y3B+fxnJDs5pzSA9k1c2fuZZE/0agwsm
	 9lVoclFml9Iny1WV6jQFNVOG9g7Zt5QWlzInD5wez6agau1TYnSqdnpGx0ygaoSM5n
	 C7iw7by+kIjIA==
Date: Sat, 14 Nov 2026 16:48:31 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org
Subject: [BUG?] perf build: Fail to build perf source with Python 3.15
Message-ID: <avkBX8dfvxaBiyIb@z2>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

Recently I've upgrade my machine to Fedora 45 and I cannot build perf
from source anymore.  The error is like below

    GEN     python/perf.cpython-315-x86_64-linux-gnu.so
  In file included from /usr/include/python3.15/Python.h:68,
                   from linux/tools/perf/util/python.c:3:
  /usr/include/python3.15/pyport.h:494:9: error: ‘_Py_STDC_VERSION’ is not defined, evaluates to ‘0’ [-Werror=undef]
    494 | #  elif _Py_STDC_VERSION >= 201112L && !defined(__STDC_NO_THREADS__)
        |         ^~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors
  error: command '/usr/lib64/ccache/gcc' failed with exit code 1
  cp: cannot stat 'python_ext_build/lib/perf*.so': No such file or directory

Looks like a bug in the python code.  I found a bug report in Github.

https://github.com/python/cpython/issues/160719

Thanks,
Namhyung

