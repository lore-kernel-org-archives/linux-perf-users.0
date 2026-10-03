Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90ED420468
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791029957; cv=none; b=m4U3TxCNvKHL7ENYGjXAwsr1UZw4HJ+XUr4TwfnYdx4E0+R1kkZa7N77BjeKD9eGrdkKh0Y9eKz5kP43HoFxyBCC5clclvXklPkr5gFNCWDJcn/Ia1DSpumqlNqAXg9EJabRZL8lJcSbue6BkZ4FbmQtu7NfYjRqtuhWjl0ozps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791029957; c=relaxed/simple;
	bh=V0/7vUbzZ2WS3ekKYc+/9kx/XXTqOYvzaiHvHZHSBnk=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=lT8eXHB5oG9vdhLlFeVjJ4k1+xkaEd2t8WUS8mP0DkykRE2jTZFwQ4kFguXgyhdTOjrxp6JhRmR3bJCpsQZpyZg6HiFVDVEhKn7xMP71I+lBnpD/+8HWhBqUfiI4npBTa29dNWfLm594Q/+ZQVJZfUXFYePWVDY+M4S70wRLNA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ya1uPvVe; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ya1uPvVe"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so161023a12.0
        for <linux-perf-users@vger.kernel.org>; Sat, 03 Oct 2026 05:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791029944; x=1791634744; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V0/7vUbzZ2WS3ekKYc+/9kx/XXTqOYvzaiHvHZHSBnk=;
        b=Ya1uPvVeeM6n17IR0e8tR+Fjn4A7Tt8xHAj2K4RCLwhM/hfRH2CLdq5KVXsqQ+7+x3
         Bjh71FLm+eHABWYeuAqtB8u41rC6u3Gv0BBngTOtNGGVVoYenWZdoIx3EaA3DW/NqxEm
         r1BZUyVLORTMFFEYNnrQzZPkAX5SzAzBvz9lKEZ3dm47fm7OGnnuU6Pf8eBH/fTDejMv
         npC3Z2mnofQdhE53ZvxxScLXy/4abR1ig/Pap4sIskWXMbYdPYLxYYrtmb8UwcnIJNTw
         789AGnYTn0CFfvhsFtKtHWJVNh1VUA9JUAmfn7mEfHa9u0CqKMUz5YKq5/iDP7QXZpvj
         C1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791029944; x=1791634744;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V0/7vUbzZ2WS3ekKYc+/9kx/XXTqOYvzaiHvHZHSBnk=;
        b=rrewzb2AZQ/UiyfU9ORYM//QPlW/BDMY3Jx0R01pMMjWjfzqOG59BKtBzc8WIU6HTT
         xP/IufCRq6+SE//+RVQewldP/7BBKNjEfYDcLlUMcrvtFcGYog0L7KYTv3LJGJTlL7Kb
         pR6ZuregDhZhwOEKv178gSt2a5Yp+tKgzJgexMNuJDUYCmoIwAerVi8YYnt454yGbtOa
         PWgBUrqbQV/Xh6NtW3ZTTQdSYuRzjrDis3QSlUhWXHq/ilDW0b2Vhd9NlhsbQNiZSjK3
         si0zeY2adQA0L/BE3LUw7SsMiibCRcJYkq5zufqqxyM0pvLtiDLsGNiQX2zL4nNiZ8OY
         Qa5g==
X-Forwarded-Encrypted: i=1; AKwUvByS24jDOqJIJiOXKK1I9XlgpmheN45iReiCaPT8v21tJwLe4QHgBr8elpKW1EFOU9G/Fv4ZRvzBHGOKT06BTWSV@vger.kernel.org
X-Gm-Message-State: AFuF++n7A+e8jsDeO1yt+aZlevZ6rl3D8R9GsUr4l14LDtYdED5ID+Sl
	Brjyp1KARl2eH4fNLXt0IosOxvLJD7w0n9UK4xpBVXTfBZYBlniXapo/
X-Gm-Gg: AYBFou1jjQE+sb/8r5hDxw9V0ZtV5DIFkJmBaTTVbpsVYParKyfIYwxocRK0QxBmDq0
	LtANO11Sw981CsEibKu2U8dJ81l1y8uj+m+MCUgP+jGoA1+3zpdL3mWi8nq3Y6IRIiwygLCHlHv
	YBwk8aDhwoFRPRkJPnbCk7XLtnyyozqydFgf3A5W/8uf7AUeUjANswsY6qFwUDQpyLRIzhYUAep
	4phqateDRfIpiJ3CYojgw/+v6uVv4P66ork2755ItBMkL8kRdP8KvonN8Wm0l6MNbPsT63RbRBF
	04ld/1QkvnjvonMu1GSVHsfHeq3Hl7J9RaWbRMV/ieeJZEIzIzAfXOrkqR8dNGist8PmfwtLcek
	OzNTJWzDmkhJneh8WPuUR/iPd1qv99p/2E6IUXjEhNsfM4VJQsGzEQvUNiQh8oxJ4HVDL4otAIh
	FgZl9vY6rZQa6o5jhqSiZz8BK0v6YbMaGgek5fD1Gybom1lCkdnePj2eYG+RI+ArBVUn4IeQ6xk
	ZJoyoffjppXvp2WUaYN/SFT/1By/u3v4oHP/3dwbXZOD3+R7hlLPwIvnzNIEpROygklxXySfESw
	/E4=
X-Received: by 2002:a05:6a21:d89:b0:3dd:a197:7360 with SMTP id adf61e73a8af0-3e0d6d8ff80mr2052536637.57.1791029943830;
        Sat, 03 Oct 2026 05:19:03 -0700 (PDT)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cca561e9d1dsm1740373a12.6.2026.10.03.05.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2026 05:19:03 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Oct 2026 12:19:02 +0000
Message-Id: <DLV74KRI1SBL.MYZVQAB3N6QG@gmail.com>
Cc: <abuehaze@amazon.com>, <acme@kernel.org>, <andrii@kernel.org>,
 <arighi@nvidia.com>, <arnd@arndb.de>, <bentiss@kernel.org>,
 <bpf@vger.kernel.org>, <changwoo@igalia.com>, <christian@heusel.eu>,
 <daniel@iogearbox.net>, <doebel@amazon.de>, <eddyz87@gmail.com>,
 <ihor.solodrai@linux.dev>, <irogers@google.com>,
 <jay.wang.upstream@gmail.com>, <jikos@kernel.org>, <jolsa@kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-modules@vger.kernel.org>,
 <linux-perf-users@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux@weissschuh.net>, <martin.lau@linux.dev>,
 <mathieu.desnoyers@efficios.com>, <mcgrof@kernel.org>, <memxor@gmail.com>,
 <mhiramat@kernel.org>, <mpohlack@amazon.de>, <namhyung@kernel.org>,
 <nathan@kernel.org>, <nsc@kernel.org>, <ojeda@kernel.org>,
 <petr.pavlu@suse.com>, <qmo@kernel.org>, <rostedt@goodmis.org>,
 <rust-for-linux@vger.kernel.org>, <samitolvanen@google.com>,
 <sched-ext@lists.linux.dev>, <shuah@kernel.org>, <tj@kernel.org>,
 <void@manifault.com>, <wanjay@amazon.com>, <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 00/12] bpf: make the vmlinux BTF an
 on-demand loadable module (CONFIG_DEBUG_INFO_BTF=m) to save ~5.4 MB memory
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Alan Maguire" <alan.maguire@oracle.com>
In-Reply-To: <7fe71959-1c58-4b6f-9019-6f886683530e@oracle.com>
References: <DLUZVHOLSN1B.115EUX4KJBEA3@gmail.com> <7fe71959-1c58-4b6f-9019-6f886683530e@oracle.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, Oct 03, 2026 at 12:45 PM Alan Maguire <alan.maguire@oracle.com> wrote:
> The only overall cost is if when we wind up using vmlinux BTF with the compressed
> .BTF section, since we have to do a full vmlinux BTF allocation (on top of the
> spac taken up by the compressed .BTF section) right? So slight penalty if vmlinux
> is used, but big gain if not.

I think it can be copied compressed into vmalloc area and
freed after decompress, so memory usage should be exactly the same.
