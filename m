From: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: sys_exit: NR -1
Date: Wed, 12 Jun 2019 12:02:53 +0530
Message-ID: <1560320989.8h9se8cb9p.naveen@linux.ibm.com>
References: <2f004b41-4f6f-3e6f-227a-cb199b8429d2@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <2f004b41-4f6f-3e6f-227a-cb199b8429d2@us.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Paul Clarke <pc@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: linux-perf-users.vger.kernel.org

Paul Clarke wrote:
> What are the circumstances in which raw_syscalls:sys_exit reports "-1" fo=
r the syscall ID?
>=20
>     perf  5375 [007] 59632.478528:   raw_syscalls:sys_enter: NR 1 (3, 9fb=
888, 8, 2d83740, 1, 7ffff)
>     perf  5375 [007] 59632.478532:    raw_syscalls:sys_exit: NR 1 =3D 8
>     perf  5375 [007] 59632.478538:   raw_syscalls:sys_enter: NR 15 (11, 7=
ffffca734b0, 7ffffca73380, 2d83740, 1, 7ffff)
>     perf  5375 [007] 59632.478539:    raw_syscalls:sys_exit: NR -1 =3D 8
>     perf  5375 [007] 59632.478543:   raw_syscalls:sys_enter: NR 16 (4, 24=
01, 0, 2d83740, 1, 0)
>     perf  5375 [007] 59632.478551:    raw_syscalls:sys_exit: NR 16 =3D 0

Which architecture?
For powerpc, see:

static inline int syscall_get_nr(struct task_struct *task, struct pt_regs *=
regs)
{
	/*
	 * Note that we are returning an int here. That means 0xffffffff, ie.
	 * 32-bit negative 1, will be interpreted as -1 on a 64-bit kernel.
	 * This is important for seccomp so that compat tasks can set r0 =3D -1
	 * to reject the syscall.
	 */
	return TRAP(regs) =3D=3D 0xc00 ? regs->gpr[0] : -1;
}


- Naveen

=
