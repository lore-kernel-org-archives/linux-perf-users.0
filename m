From: Muni Sekhar <munisekharrms@gmail.com>
Subject: Scheduler benchmarks
Date: Tue, 18 Aug 2020 20:00:11 +0530
Message-ID: <CAHhAz+inPwKYx_4qaujQ=bGG9twashiuqLhQQ-+vgHWF7FLhRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kernelnewbies <kernelnewbies@kernelnewbies.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Hi all,

I=E2=80=99ve two identical Linux systems with only kernel differences.
While doing kernel profiling with perf, I got the below mentioned
metrics for Scheduler benchmarks.

1st system (older kernel version compared to the other system) benchmark re=
sult:

$ perf bench sched messaging -g 64
# Running 'sched/messaging' benchmark:
# 20 sender and receiver processes per group
# 64 groups =3D=3D 2560 processes run

     Total time: 2.936 [sec]


2nd system benchmark result:

$ perf bench sched messaging -g 64
# Running 'sched/messaging' benchmark:
# 20 sender and receiver processes per group
# 64 groups =3D=3D 2560 processes run

     Total time: 10.074 [sec]


So as per scheduler benchmark results, clearly a huge difference
between two systems.
Can anyone suggest to me how to dive deeper to know the root cause for
it. Also are there any tunable kernel parameters related to this one?



--=20
Thanks,
Sekhar
