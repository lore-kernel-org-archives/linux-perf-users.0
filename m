Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E3F377A85
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 06:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791009488; cv=none; b=Fdz/9Yt8ivljllKNE+FcK/7hgiB839kStRJ3j9WqTaIfci5F9GZnZlv1zccxJlnxd62jlPaDlT8Alnr6AruTrAW6XfTPeHT6RcU4WoRZWdUBBvlh6BXERqEacJM3rCaEoYLDmuG4m1Ku+AqexExt3si6b964GO6NJagZmdcRoSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791009488; c=relaxed/simple;
	bh=w2CHf/Ruyl0ieMWiVy7QleNiafjxfD+l+EFZ1XXXNB8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=Gjj++TDCAONvjGdQq0b6GysNdNPhVpMyGoq+GdRYewWUVZiAeVoQSDTscfZBRVTrCf0fUE+F4xYiHiQwqOoeJmOTbpJmNgGfohwOAIWGMaVbZ09TE2UGz7omfW1i4Sa9Qb/Hxcqtdl/BEeGnC9oJcSKz32d1b+t7EX66jnFk6jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ir4gbnxE; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ir4gbnxE"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc78dd412cfso49910a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 23:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791009484; x=1791614284; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rn5qy1uct3HxkhX0TLP/tcAeQOQET/L/4W2RbNiSgQ4=;
        b=ir4gbnxEYnj8MisDdoh2wYz7JDHlJTCmhf8medao28SMIzq4NAWkf0ReXrErcyRePu
         KYL62hbQCDuBRabP53yqOzo21q9Z1Qu3JS02vsmrsF8lbmufMc4VpPVBKi79MTCXIo33
         8wUcc7BS5tppb1lzOCyUW7Pbd4tZpmLBF0s9MhdUEdgZxxOIoFlh8nRqh77cIJ+d1Kom
         XVc+9Py5vO/ZY7NNBhTjHYlKbzBd2zgUgxGmrTTjIPGnpaerNNgFmzGLOupGDtJvz9op
         e7c8gqGeTkF4yGlIJr6T4txba4hezFKH+14YeDOtMxg+o3hzr8eeMmp1c+W9zjWzOzVO
         MJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791009484; x=1791614284;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rn5qy1uct3HxkhX0TLP/tcAeQOQET/L/4W2RbNiSgQ4=;
        b=oBYXK5gjddXjBLztePa1xKd9bbKaHM//TkG9A4SnRreBMpxdmIV7xhsu5BTxQ8DHi7
         QaPMb3Ueae5S3tXF47FaCYLhgoYZDAkx/khucWY6gIYLMyKhgUYue7wmPVv3qyxOV3df
         fREVKnb9IO9vuPn3BRP51A4GQtuPlVcltq0wsJtuOPZAqJIIzBJCkk+jh37Dpu/+tXRR
         IV6l3ijpt/+ahekHViTjS9djJ796khnqFjNLT2PcQxcRwtWjE7QmfORqpZrmPqF55Gb7
         G1g6LTncrp2loUsyJ4QOihpGratkLJfxRGhwR1u1H003xSHRDqfNandg0TZHooG7A6KZ
         17ew==
X-Forwarded-Encrypted: i=1; AKwUvBwwK/qqQaDQiqceoxCaUKd4Wpv/jNJuhLmZkRa0+i6ko+UQ2Wc51BKscHklVm8zGGTNC9T5Ic7XfiwQIXRkBHy2@vger.kernel.org
X-Gm-Message-State: AFuF++lAnR/ELgS/YnOYqwvXbmW1smrNgkTBJtganDF9hlf/j45/SZS3
	J6YPoeEdgaWTGM6Byp0BFKzccIKxAI9miF3c7ycNDgi4x7PrsJd4XP/i
X-Gm-Gg: AYBFou1vNCzzMkvitnrGHI0TWcUPMwuIOEukWH/V5t1LB/peOkCl8lKPKIVrtQOCjYe
	dqcTfu/CCxnMX5d6IgCxM5Ir14N/n+ykHhigP5scRu0N7MCedKpNdUkWNafM6qrgzXNHeOtUEwV
	v1/KZ3szbq0Gcj6T2GU8e0mIE/s0URZsykccXatY+tCgJ3sSRxtfmtk/XkpgV833YLY69h6TxAA
	A3A3PCndxnO3beBCS6S6uaYP0oeJPUZQy5pu4LtcKNQUsoUVthPbBt6ncDjRhuXR+9ZGqTjJCvH
	m/HQp+IBtdXNKxByQMbm0x7CZLg7YFeUWqVwvyVwtJCXpehCWeSmaUiOAQgKhbWWDbc94EySzWE
	CKOAJgP0Z5cnxR/SCrv+UIX/laQHfE+iXQN35CQYc82rIy4CZavoxNbAq4BwZnYyCMU0/DEljBm
	z938vLXGLpuKDOlVxzE/mjX7e70yIg/jXy4OwAb/PYB9j3yIOynZNbZOpU4C4/3u2fpwtObKCq9
	qAYOUi658YIPZjsSMonMaRz8aW6HgP9/zoE093l3DWAFYLj1kElQLdzm15QmaKyO4et4MIO4x2J
	cX8=
X-Received: by 2002:a05:6a20:7495:b0:3e0:b778:d988 with SMTP id adf61e73a8af0-3e0bd4bff2bmr4998287637.83.1791009484332;
        Fri, 02 Oct 2026 23:38:04 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7370db1sm1809155a12.17.2026.10.02.23.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 23:38:03 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Oct 2026 06:38:02 +0000
Message-Id: <DLUZVHOLSN1B.115EUX4KJBEA3@gmail.com>
Cc: <alan.maguire@oracle.com>, <martin.lau@linux.dev>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <qmo@kernel.org>,
 <nathan@kernel.org>, <nsc@kernel.org>, <linux-kbuild@vger.kernel.org>,
 <linux@weissschuh.net>, <christian@heusel.eu>, <mcgrof@kernel.org>,
 <petr.pavlu@suse.com>, <samitolvanen@google.com>,
 <linux-modules@vger.kernel.org>, <rostedt@goodmis.org>,
 <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <acme@kernel.org>,
 <namhyung@kernel.org>, <irogers@google.com>,
 <linux-perf-users@vger.kernel.org>, <jikos@kernel.org>,
 <bentiss@kernel.org>, <linux-input@vger.kernel.org>, <tj@kernel.org>,
 <void@manifault.com>, <arighi@nvidia.com>, <changwoo@igalia.com>,
 <sched-ext@lists.linux.dev>, <shuah@kernel.org>,
 <linux-kselftest@vger.kernel.org>, <ojeda@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <arnd@arndb.de>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <abuehaze@amazon.com>, <doebel@amazon.de>, <mpohlack@amazon.de>,
 <jay.wang.upstream@gmail.com>
Subject: Re: [PATCH bpf-next v4 00/12] bpf: make the vmlinux BTF an
 on-demand loadable module (CONFIG_DEBUG_INFO_BTF=m) to save ~5.4 MB memory
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Jay Wang"
 <wanjay@amazon.com>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>
In-Reply-To: <44315425-c505-46fe-8379-f19d78ff3abb@linux.dev>
References: <596bfb65-db2d-413b-8039-c921031b50fd@linux.dev> <20261002073422.14253-1-wanjay@amazon.com> <44315425-c505-46fe-8379-f19d78ff3abb@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 02, 2026 at 01:58 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>      Keep zstd-compressed blob in the kernel image and decompress and
>      parse it synchronously on first use.

imo this is the only one of the three worth considering.
