Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C841CF9A
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Nov 2023 19:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdNo42EC"
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EC7385F
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Nov 2023 11:49:33 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7ba46683a88so1241497241.2
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Nov 2023 11:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699732172; x=1700336972; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5j5ORqOeOj7sXDS4Of+hRK9yCyfga8GHZTBmC9Jaas8=;
        b=MdNo42ECFDjEAblRXM8BoY5v0uGGL3dVQ/zkiqPRFPyyJpOvpmNcT8r+0yH+edVJEt
         cCTYAP84HGKCwarFnrLMtlupJqr7WqueGpNTjeWfHl4SDwv1DZZ7ucHDQX7hX33nnE1q
         eCcUDM7IFA+bJn6Vh46X5IbA/XgikjeH3KKwa4M3K1yfoRV30u7dB/lnbDwKz6k8sIkk
         carAB4fIyfvUbzVsxZcm5b6IW1KRL9j5myO2ZI0gFjZmjDeUHcjPJLRlhXS4ZA7fS0cM
         5CiutqEF/AzNNWM3te/9W+TLQ5B/o2NRpDHPwSnuzz9KYk1DlADTFAdJIBD4BBmGXi+a
         iohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699732172; x=1700336972;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5j5ORqOeOj7sXDS4Of+hRK9yCyfga8GHZTBmC9Jaas8=;
        b=Z232QcKjRrGvmVSFXnzs6u6Z0FixW8cfRg8XNwYw26CykPql55tf6eFbs1NNkUoyq3
         zPCor1nebS16+ri07rZFVJMpxWo6PYX6E7uBP+NT5SQXpWvSbszosm3NXOCKY5rw2Nw3
         rEv7YA3OBGZ0cRQ2IC6PYSyH6LUZebkkpJ38LE72b8DsOaEBFM7RMWV8XXjH6SuTYhmR
         iiBUcfaZ8gjZHafiZ/1Iu8QBVznajLnQo34mm+7/dIfR6AHGX7J4b3LnKkZod3WCDNAa
         kFjyXxIeBS9Lb1xXabr/0sZt0VgKZnwpHnFFpYtMswsulyX5OgMX0wxeEoNJaaZWCShF
         sP7w==
X-Gm-Message-State: AOJu0Yw5hkHvG/8Iz5QSH+PWksHyOyyk8iNuPtbhwY2EaOMyvLMGN8B5
	RwNTKdgaY5h+tsU6+nL9Xa9rZB6SjgEKTcK6H3e+L1E+n8o=
X-Google-Smtp-Source: AGHT+IF0EtEYWjVoi292ri7bR3nviPjfURKHf0eejJV4ENa1kXea2Zg1X0u7eRKScjLHKttZtorMkL/P70VlwNISoTk=
X-Received: by 2002:a05:6102:4a85:b0:45d:aec0:9aaf with SMTP id
 hz5-20020a0561024a8500b0045daec09aafmr3391224vsb.27.1699732172158; Sat, 11
 Nov 2023 11:49:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: jim.cromie@gmail.com
Date: Sat, 11 Nov 2023 12:49:06 -0700
Message-ID: <CAJfuBxyYPdKtA_XCmpdb-qexM0ux3mfNHxCTJFimQ_MycCyeqQ@mail.gmail.com>
Subject: how to measure cost of 'cat /proc/dynamic_debug/control'
To: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

hi all,

I have a patchset which "condenses"  module, filename, function-name
columns of the __dyndbg section into 3 maple-trees.

This reduces the #entries by about 80%,
so it seems likely to reduce overall memory footprint.

accessor functions replace the raw field derefs.

`cat /proc/dynamic_debug/control`
is an ideal workload to evaluate the added cost.

that said, this doesnt appear to be seeing that cost.
   perf stat -r 200  $cmd

bash-5.2# uname -r; \
time perf stat -r200 cat /proc/dynamic_debug/control > /dev/null; \ uptime

6.6.0-f2bi-00037-g078217875494

 Performance counter stats for 'cat /proc/dynamic_debug/control' (200 runs):

      21.73 msec task-clock          #    0.628 CPUs utilized   ( +-0.45% )
      44      context-switches      #    2.025 K/sec              ( +-
 0.12%            1      cpu-migrations         #   46.020 /sec
        ( +-  4.32% )
      73      page-faults              #    3.359 K/sec              (
+-  0.11% )
51894505      cycles                 #    2.388 GHz                ( +-  0.34% )
165896      stalled-cycles-frontend    #  0.32% frontend cycles idle
     ( +-  0.23% )
  83546      stalled-cycles-backend    #    0.16% backend cycles idle
       ( +-  4.23% )
144663807      instructions                #    2.79  insn per cycle
                                  #    0.00  stalled cycles per insn
  ( +-  0.28% )
 42439211      branches            #    1.953 G/sec             ( +-  0.28% )
                 0      branch-misses

          0.034600 +- 0.000119 seconds time elapsed  ( +-  0.34% )


real 0m8.994s
user 0m0.120s
sys 0m6.888s
 14:04:11 up 53 min,  0 users,  load average: 0.15, 0.03, 0.01


Comparing that to master, I dont see much difference,
which suggests Im doing it wrong.
(adding > /dev/null  does more to reduce work than the kernel change
increases it)

Can anyone suggest a better perf invocation to distinguish
the relative cost increase ?
