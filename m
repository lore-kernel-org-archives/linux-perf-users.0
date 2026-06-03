Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADFE39A4DF
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780501016; cv=pass; b=LZdgVLCeIYnT1+CIHg2u2bwO5WiLXolEFcRacmIOct7TV+CbR2onrY5XmnWCiScegukVDPG+sQHczhUNI7JJckpFpmoW56OoJZpfpJy8guUe1uQdbAfka45oGHcAn6NWqW7XehpN/yHO+vP0m2SpbUtGx+wlT8+exR4h2Ce9TLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780501016; c=relaxed/simple;
	bh=7iFh1edn45JTkSJyVUqTC9ywPBFt3B6QYQOEvY3M5Do=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=AoKvfFwOgyT5hooVrrtIayk7Svg8Llr6nO6dvDtqY1Dnh5zOPHTYpvpq3hYfNHACwQyQ/4FbAk8H6IjsuUl4QBYM/wydRnRRnNlTIrIoSc+9xRkbYpfey/SxIhpC8foswMavtJ0vtFMve/sD+YGfzI+yizNhjvHyGQ+NU9sY8U8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EATQCfIu; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EATQCfIu"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bf2d865383so81815ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 08:36:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780501015; cv=none;
        d=google.com; s=arc-20240605;
        b=guM8ImNM5aTk/SG1WsHvAMQPLIvMoGkBbJZXU7X6x003jQIBNVQKVyEqv5d0RCq6fW
         WqMmeczaye700qBJAEkgHUHAqzzz63UvUS+KRoK2aNI5drl/yvNNAvhHdb89udvLh8Co
         G7CpOzfoOwBLnq7ykdVPCAWm63atTYVd2/V+wylvhUOPluC7miUhgsNFvgYVhv07ooe0
         M77bPVyO0iRB8cqKQg0ieKqpZbpXB3aYdR7Uu4GjDlzigp/T5Q6a8E4OhX/H0jIf9vrC
         kshw/XZMkppWjIW1QfEfHm53Zb5ZG5nFXwN3qMEXlXntmsxApQGdMbtZznbmT+0QOpdD
         AcCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=7iFh1edn45JTkSJyVUqTC9ywPBFt3B6QYQOEvY3M5Do=;
        fh=5nDXrkfolhvHp3itH7yNJbk5u/IkIknPHd2NwYwSegg=;
        b=ido760157GOHf4cF5Tn9qurpaOceSED93ooUgXwLRSDqAkqRHTEe2UcQ8RwTnqVRei
         zVRq0lmE3PivOMy0i3OMuSraQZxId/Vp4pKyLx1T0a0fzjznAdiWJ8PGgKTRoX6Uu2vy
         7ZXabeH25Cuo5SP+AnYayCGDf4Kqo1mRRwDjsDLLOzFfd4El2Crf0WWWcJ+P3HoX0V0O
         H9UjBbEJB7j+iox8ddGOFO6CNS03H9AtgpbvK46Zra0TriPY7kiDPtyWCoMfSDOgEt6N
         VVdSMg7mZw+ll8AUCYHHOh96D9n9RZEc5Z5mpz3pwJwWHcA5OxAvdAGaanKIV5CW4IJS
         O5Fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780501015; x=1781105815; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7iFh1edn45JTkSJyVUqTC9ywPBFt3B6QYQOEvY3M5Do=;
        b=EATQCfIuN/hxOyHjXZUTRmYjAj17BRvV7fVPeSkNCl/63AClTJNMDa9kZ6QbOHXPnM
         LFmXWDOt1q18IQRLRH2VGgaCGHDSuaeTag+OoDk2Xu0zEBRAT1O5O+VeQYyVuTlRRv0P
         fZfzAo0w7Jr6PPvElY+dfwzykRfjKKWE3mpmmMTNPbmX1qTjt0u6llMgahMMfu7ldlt3
         dxpij8l6aWDql/Q+ubjSyB5kkjfJwP+17ly0QCmomLLNht9rJSTt456DdLnFQHils0mG
         VXLjUvrwNt3t7oBb3VMpmb+YpAvMHSheyWkWH7C5RoPiNRxTVo/NQwcZWMHP5Ewwcezz
         12RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780501015; x=1781105815;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7iFh1edn45JTkSJyVUqTC9ywPBFt3B6QYQOEvY3M5Do=;
        b=PRWeXXeULH6LubnAwGf5+KzfivJsfwEoO08ecd5n9yxJDPFvy+Nfj5QwIG1Istlawu
         93P0/TOZ/5aU4WOaToe9B6JGtuIfVYqF9T0ul0hh8QSzEspnQd1/Cr6Ppz79CWI+7CQx
         dH8z/BZG9G/vOnAeJHhNP3pCO1WDkT3KI5phrPmAu5H30hOGcmups1tZCoHvBosOo/wm
         r2ZnWVNICDGniT+p9wfITTQh9Plt03ZhaccXunWKudFgjeqnV15PIDOmkXMfSLdMHNde
         TCaU58/k/pLMKYZdobZHLcdUJ/iOIaeLDSsAjUs+VUyIWgSNpstxa7trtcJ+eQNxndm8
         MORA==
X-Gm-Message-State: AOJu0Ywssza6t5PpbkjEZaY8X4uvAPnlmyax7DThiAPrMhBioeg9BKkO
	6p4QjErh+6QpBnrFVOyRCg+MQdUVqC5kbBxCFsWj8eoGOFPuJ6iAYHBHnnecminOJDRM70/fcS/
	KXRvnjuRp1dC2L5XRXbBE03IplAUVWfAxSED4VYxb74s9dtEl/NkBlBpiWTA=
X-Gm-Gg: Acq92OEBYcHXqje5TEOqSwxhs9jmDulwhIgHGmaHkmEYNo7wrTBDB7Y0AMmRpanRWdg
	iRcixczMyKWIKzq6JRZybA+Vwbp0ShfJb8xtY4JOQdxfmpi7u2h5m5qQUPKsIAVf/gs4EsOsW6a
	0c8JJ9OssSaMbqDfqOUNuc/7/0Th0l3C4woLy0HCllDQe6789Le52sUG4dQ2s1kJN8WW2X0YURU
	1/NKBJNylkCjESGKzRQ+n3cA1+OMDIVka1DrpkLlpQx3DaQY98qhwlmXqmUKr/FfQVRA6bYII7I
	OOUFZexVx/c32BLA39nvKtzcu9lsEMt9Bu1XD1CD3GI41P3D
X-Received: by 2002:a17:902:c405:b0:2bd:5fc9:27b9 with SMTP id
 d9443c01a7336-2c16fa720bamr1735185ad.3.1780501014163; Wed, 03 Jun 2026
 08:36:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Jun 2026 08:36:43 -0700
X-Gm-Features: AVHnY4LqaMAyOyFMzYTFxGwsk-MFELZCu3EvLQswcE8Nck1sDj2qE_lbC7lG7tc
Message-ID: <CAP-5=fWRS46ripc2dMyZfYE_1m6wLnThaVAi3kT5aMFd1ARBiA@mail.gmail.com>
Subject: Musl and ERR_PTR review prompts
To: linux-perf-users <linux-perf-users@vger.kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

Just wanted to give a heads up that I sent a PR to improve reviewing
for these two issues with the Chris Mason prompts (which get
incorporated into Sashiko):
https://github.com/masoncl/review-prompts/pull/72

The ERR_PTR guidance follows receiving reviews from Sashiko that
encouraged the use of ERR_PTR.

Thanks,
Ian
