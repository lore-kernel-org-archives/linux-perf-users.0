Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792619895;
	b=w4tjWSCko8spCoQ3mFKumfTzqFYNJ2WK0Bta/HYuJH6yIGcaP/K70t9MU45U/Zjevr19
	 rqLU1Xyv8PUbHYEKFBa8lpZbIK2mXsZCAhWkxS/UmCO81XsXHK0XvOpvDMge1ZKWT7TUL
	 Cc0fJxwIhAkP1ssIq6zFwERG2RRCOnrk8LAQLxjNeG9wH7g1F11Gf7ALzwZe6DrHmLAH4
	 PE2p33JpzOISdPPDdFttVTthTq0/zEXDJso3+AgZD1+rIuvpDSY+CctitLGj8h3m9h3wH
	 Ed/2zc+aGoVktwf0mRVtQRRTr6dZRUe1oBq+PasytPt6Ps+yzWrGrEWC/RRZzcGG50w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792619895;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5yJ2n3i6CVJHjK6ZZv5a8G36fnS8e4GCGU0tMgw75a4=;
	b=VTLD9KwxzYa76NZ34j3ffV4tt3NqRVM8DVYJHqYdsSV3QYHHTGFcycsEiIDM65KCNnCY
	 x6bnyJntjo9SJaL5uePglbV8ODZrce7Td00659qtQIYyulp2XHqu12gJlRNCGuPFJie0V
	 TgnYy4v09kjgOCMNMajFzAnqpRe2JF5utiXAI4zhUtGgOOJPcPOhmRbVXYJlrCx7Qj0b2
	 RrzjYmGcOoLw2oZcVIgpRkyX8ay2oDTESLp1VaDivH9i7N8PIuxMlkPM8gkYlvbx1nqDW
	 aU/E8SWRPuKb4xmV/AP430SQBr0gUA2FZqgVPJy3UoMp+3NSpJTWpc/aAhohw85iJtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Wj1f68AR;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A26606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 21:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3A26606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Wj1f68AR
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a1e477fe16so7172215e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 14:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792619893; x=1793224693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5yJ2n3i6CVJHjK6ZZv5a8G36fnS8e4GCGU0tMgw75a4=;
        b=Wj1f68ARfWBZ/74a3qmLkQ8FHsanPBpng52X9RNK5nMb67Fu/KWlRlocKVzYXmt0rB
         6QlqdcsruaTm7myqk/xti4GJEJP5D8JeS+Ivw8qfmTPDrv5xaAtx03JHlQ7PX8EHw7oY
         nj9aSrWiHLGYB6P8Uw/k3/mMc95SGnC/SUbqTEIsdH9fZxMwxltXEMOZSdayZXCNxq8w
         1LSdJvdC6zdM7wqgeYEuBAFsAOHl3Tv2poNqRGpWRN47cyOpz2FlNjhxQ5HEOd6tE1q3
         PWS08VdTKDDdWsL46LbT5ohhFNw9KhWPMmxpOvIUF4mOBxy0LyH/h+ys0F7sBRRx7vRN
         q5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792619893; x=1793224693;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5yJ2n3i6CVJHjK6ZZv5a8G36fnS8e4GCGU0tMgw75a4=;
        b=hW5LIIjLu6LmV6Su36FsFwzFvqBEhZYyDgLfJHlKjczAjWJUpQHIzG7A0HM33tN35O
         hu0azRYSLH0cqVM07SC6+dFBbVznQrFq11FfOPDWFCSpHSW1EgQjodBTiy25jVMsQsQ3
         9qwUmInE2Z6B8GAIZJUFRAIuMWoAkvJ6jMFdhPySJDFmjXJwa3uSX0e/0sBKWA3R5oiR
         yXWVaklDKD3vDe3QgakGnTNY3DCUAHcIo9f6hvrgpVHyUSM7wup24kdH5/dQzTVPnbJs
         31DK333/nOGozZk7xbq3TKOg7O9pwcKc10Gl4q5Ez+lTid27EIa8aRskAdu5PQ6aeM9C
         oIjg==
X-Forwarded-Encrypted: i=1; AKwUvBx2M6Na8zPXaaerCf3inveQ9l7bOAzb0EcsHvW4jiKbeWKfWFbsjrpQ4noxIBdxJFi/X7l8BfvM0zMIup+S/DQC@vger.kernel.org
X-Gm-Message-State: AFq9FYJhefQeHnFRBkOJdoKdQLAmqU9rRSw5jPAHU/Z7Pw0PA2rbQwQ1
	riLIuqBVgzPa2ZqAaQnPIEdyWFh9tNxiFQWI4/VBVX8KlAhcJ8mgM86P
X-Gm-Gg: AYBFou2wd1j0XOVdhIG3mNO9jM6vJ8RjYoFiYf1vjJFtQELHP3yMK14szThzATHoQS3
	QKMXq8wTykgnxaZpwPFS0jjijXdhLGM8lOZqYYkdSvvNxL80AHkmvrJPjO/FQS4pFmF6wfZjHy/
	0KhQSwsJ9DuFYmAI+hmIgqBdVE7omb1obtyTW3S0plmH0Grwi6wQ+Ne9UP1mijKaC9+DdbCx7vx
	Ef0ckHyU5MBZfGpj5+LmeIt1Mw0dJYaKQDGdwFOHuJRvSjF6VUStsPlPfDdt1czBJfkJ/7Dq4Ae
	Jm9i3IusPcoM+JmXPrIGg19OwSs2nr67L2mRPhWNlP0IrLrmDKpC2nTYB2SP6qH5BnePp3cWZ09
	gmnKpRv+M5VEuX+ItLzW/iS1MFSvJPgD3uye8Di/ZbBg+ASStx9Kx666ntxsac+G5QvjKHjNNWf
	HSXluUQv/HD6nCFxmEj3Og4/gay567ar2Gc+km+X00Ku3AawcrznBaJjlDQ7dGO2RAi2JEskr7+
	PNq2X0nfmj5Yaa/LOehI/guSXR4RLemgyiYLDLvonipSENCAp/QoQ5NdnVAI0epVIHAYYk61hPO
	S1aq0ptb/aZmfA/J4bFNb6w=
X-Received: by 2002:a05:600c:c116:b0:4a1:7659:9b94 with SMTP id 5b1f17b1804b1-4a1fdd15d29mr64090935e9.13.1792619893139;
        Wed, 21 Oct 2026 14:58:13 -0700 (PDT)
Received: from gmail.com ([2a01:e0a:bc7:8550:5cd1:725:a99a:721c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254efb2csm8588852f8f.2.2026.10.21.14.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 14:58:12 -0700 (PDT)
Date: Wed, 21 Oct 2026 23:58:10 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v1 07/12] perf beauty: Update copy of linux/socket.h with
 the kernel sources
Message-ID: <atk1cuJe3pqUvBya@gmail.com>
References: <20261021213007.21046-1-acme@kernel.org>
 <20261021213007.21046-8-acme@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021213007.21046-8-acme@kernel.org>

On Wed, Oct 21, 2026 at 06:30:01PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> To pick up the changes in:
> 
>   be3a5e06b962 ("net: add SO_PASSPIDFD_THREAD to get a thread-specific SCM_PIDFD")
>   5bd369c05576 ("net: Add connect_socket() helper")
> 
> That don't result in changes to the string tables generated from this header.
> 
> This addresses this perf build warning:
> 
>   Warning: Kernel ABI header differences:
>     diff -u tools/perf/trace/beauty/include/linux/socket.h include/linux/socket.h
> 
> Please see tools/include/uapi/README for further details.
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Mahe Tardy <mahe.tardy@gmail.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Mahe Tardy <mahe.tardy@gmail.com>

Thank you Arnaldo.

> ---
>  tools/perf/trace/beauty/include/linux/socket.h | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/trace/beauty/include/linux/socket.h b/tools/perf/trace/beauty/include/linux/socket.h
> index 2a8d7b14f1d11959..b17fdb7d38a7734a 100644
> --- a/tools/perf/trace/beauty/include/linux/socket.h
> +++ b/tools/perf/trace/beauty/include/linux/socket.h
> @@ -189,10 +189,11 @@ static inline size_t msg_data_left(const struct msghdr *msg)
>  
>  /* "Socket"-level control message types: */
>  
> -#define	SCM_RIGHTS	0x01		/* rw: access rights (array of int) */
> -#define SCM_CREDENTIALS 0x02		/* rw: struct ucred		*/
> -#define SCM_SECURITY	0x03		/* rw: security label		*/
> -#define SCM_PIDFD	0x04		/* ro: pidfd (int)		*/
> +#define	SCM_RIGHTS		0x01	/* rw: access rights (array of int) */
> +#define SCM_CREDENTIALS		0x02	/* rw: struct ucred		*/
> +#define SCM_SECURITY		0x03	/* rw: security label		*/
> +#define SCM_PIDFD		0x04	/* ro: pidfd (int)		*/
> +#define SCM_PIDFD_THREAD	0x05	/* ro: thread pidfd (int)	*/
>  
>  struct ucred {
>  	__u32	pid;
> @@ -461,6 +462,8 @@ extern struct file *__sys_socket_file(int family, int type, int protocol);
>  extern int __sys_bind(int fd, struct sockaddr __user *umyaddr, int addrlen);
>  extern int __sys_bind_socket(struct socket *sock, struct sockaddr_storage *address,
>  			     int addrlen);
> +int connect_socket(struct socket *sock, struct sockaddr_storage *addr,
> +		   int addrlen, int flags);
>  extern int __sys_connect_file(struct file *file, struct sockaddr_storage *addr,
>  			      int addrlen, int file_flags);
>  extern int __sys_connect(int fd, struct sockaddr __user *uservaddr,
> -- 
> 2.56.0
> 
