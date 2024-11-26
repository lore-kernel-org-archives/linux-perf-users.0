Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68481DFE08
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Nov 2024 23:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732664012; cv=none; b=GQseKg3qKEsQOg56GSTwL7a1F/kbahRxzzqUPn1h6ZP9q06d+cxTZLZvwiNJ9wE6KLtL5GTkNpp5SuId0oNAx0zwH3BNwuuFGjeL3RR8AN2AkSKFTOUehtr93MtqaLG0oUs36VE5p1RLEID3de8U6zxobF29sLBFbuKBBmsXxBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732664012; c=relaxed/simple;
	bh=6T91vbcoefGNJCw9c0uoZWNFJ/ID0VtTnKcS/ejrjyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kbizWbFe4NOWgBDRzI0TVSXJWFAbyFlfSMNRaLOJgJMTnYq7rOx6i0BcEXtcNgxWqOL7LE9eR6BtyhcCA5AMh510ySFKG9ef40gtprNkUccvt6zN9zb36CwYzFeFbswWWLOIvWpR7NryZRRd5kEmsW8mXXcEAxeIqeUIHGuDtUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UulNPFtX; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UulNPFtX"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cf9ef18ae9so439048a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 26 Nov 2024 15:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732664009; x=1733268809; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bLwSUJtOTgfC8HrzNmFuxmXt+8eehSMuWV07yWPRKKU=;
        b=UulNPFtXJzwUa8F+5njRis2LsjRzVtTXk+YxneS9IwWPBGdughMNj8coJhlUj2rxTE
         bXsS+g4qNy6xSkSuT5P9phPsgBKOmWwOQbo29p1n/Wmjy9ExgKaRy/JFe3Fjs+7LRu9v
         Zx7V79RN48Wbt0NEq6Mm6qyRlyoKTXVNmcU6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732664009; x=1733268809;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bLwSUJtOTgfC8HrzNmFuxmXt+8eehSMuWV07yWPRKKU=;
        b=UeThHVaN2KcndhgA9YyR6TN30M4ukyBqw4JkwYDMTm8Y1CWyqmKJwzV4v5qa7hKOze
         +V0RFKhLzLpGco6f9q23kiYbYR/4vItPDeA/DCEhWCBaxifBeEjzgctlGTpP7OZ6KIT/
         lkp+JBzivUkrZvsBXCEqnvAhKBdW37jnAdrrtXhjAr+6lQ8VLt92ilTbH/hamv3AETrP
         9FwQYlqAPz++6kVH4hqJPqZybkruXTIUWQO7MRnA1aR9daOFc0e2uVu4TECimkQ7z8dg
         GLv9kv1CzF02kFxxKqpl/1bwMLPj+adYTVgi5a4J5GX0aLN3TLiYjz+Qz+VhdBT+GpAS
         PYBA==
X-Forwarded-Encrypted: i=1; AJvYcCWzruLo+Ft6+LAGOs7gLAlf/PM1rofL+RVeMIGSKlItEhOfUXOJk43Z7fqYFPgTcAmyv147J3LvxeZs9/Oc8YqF@vger.kernel.org
X-Gm-Message-State: AOJu0YyfmOOTbbXJOvepMbaLuJjrKna/q6TCm+Dmqx9+SfQyh6TTXV82
	BT0yHxujOuKN2nrgkzwFCNJ9Qr0dD592peajBmxiD6b2RHZYeE0KMqs1bWjmEEwI5ER0bmD8JZp
	q9+nZhQ==
X-Gm-Gg: ASbGnct01vVskyzVuCGtSgmNAiWVS5st+WjFk+ps3+AHCRfMK0bqv5s528XdcyjHoYl
	Gy4oVxRAYalMIigzjz5p3Z2l0TgE0GUfwhqMD77MKMwjZXCYDehszvVhuTTsuWhDSt9WJL6vxHP
	zgmO3TgH34savG7nd2vlzncjkgktTC5oxD0rUd00Eef/kUQqFQyx1Vd/LbCpO3c+hgm9swgMXra
	vkzymuVRqAIlzViD8zko7s3UZ5Fy5EbRASvaCT831M75/AU9zr64vH9AUU+gVEdfqAqBG8+cgxh
	wURJ4zS+ott7/Jgnhj1tTMjO
X-Google-Smtp-Source: AGHT+IGQf7XKyJeWGt55sFzofl8eI0KnBMoKFSitOM32bmQ6mV9r1kxq09sItvrOA9kqlD5uquy3AQ==
X-Received: by 2002:a05:6402:2689:b0:5d0:840d:ed02 with SMTP id 4fb4d7f45d1cf-5d0840deea3mr116795a12.4.1732664009149;
        Tue, 26 Nov 2024 15:33:29 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3b0c64sm5547387a12.33.2024.11.26.15.33.27
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 15:33:27 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cfcb7183deso475223a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 26 Nov 2024 15:33:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXUQjR+pY2QKmUjMGI3zopl5e5mYjN6x+4XByHfzG50WflSD0wPUbhRi7NAuMxcvW6iIPCHJYE4RjvkGQsNshEv@vger.kernel.org
X-Received: by 2002:a17:907:9409:b0:aa5:2e71:3727 with SMTP id
 a640c23a62f3a-aa564970687mr514064866b.21.1732664006733; Tue, 26 Nov 2024
 15:33:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125071653.1350621-1-namhyung@kernel.org>
In-Reply-To: <20241125071653.1350621-1-namhyung@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 26 Nov 2024 15:33:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=whQ_yeRDh_zZjhz-4q8G=vu5Ypb-Y3f=efHQSwd5Kas3w@mail.gmail.com>
Message-ID: <CAHk-=whQ_yeRDh_zZjhz-4q8G=vu5Ypb-Y3f=efHQSwd5Kas3w@mail.gmail.com>
Subject: Re: [GIT PULL] perf-tools changes for v6.13
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Nov 2024 at 23:17, Namhyung Kim <namhyung@kernel.org> wrote:
>
> Please consider pulling the following changes in perf tools for v6.13.

Hmm. Has the default search path for the vmlinux image changed?

Doing profiling with this, I get

    openat(AT_FDCWD, "vmlinux", O_RDONLY)   = 5

which is very very wrong for my kernel build - it basically picks up
the vmlinux image from the build directory, which has absolutely
*nothign* to do with the image that is being run at the moment.

So now I need to point "perf report" at the actual image, which I
didn't need to do before.

            Linus
